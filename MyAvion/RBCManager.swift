//
//  RBCManager.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-15.
//

import Foundation

class RBCManager: ObservableObject {
    
    var baseURL = "https://paywithpretendpointsapi.onrender.com"
    
    private func refreshToken() async -> Bool {
        guard let _ = await login() else {
            print("Failed to refresh token.")
            return false
        }
        return true
    }
    
    private func performRequest(_ request: URLRequest) async -> (Data?, HTTPURLResponse?) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return (data, response as? HTTPURLResponse)
        } catch {
            print("Error performing request: \(error)")
            return (nil, nil)
        }
    }
    
    func getMember(memberId: Int) async -> Member? {
        let urlString = baseURL + "/api/v1/loyalty/members/\(memberId)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(Keys.rbcKey)
        request.setValue("Bearer \(Keys.rbcKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = await performRequest(request)
        
        if let httpResponse = response, httpResponse.statusCode == 200 {
            do {
                let decoder = JSONDecoder()
                let memberResponse = try decoder.decode(MemberResponse.self, from: data!)
                return memberResponse.member
            } catch {
                print("Error decoding member response: \(error)")
            }
        } else if let httpResponse = response, httpResponse.statusCode == 500 || httpResponse.statusCode == 403{
    
            if await refreshToken() {
                
                request.setValue("Bearer \(Keys.rbcKey)", forHTTPHeaderField: "Authorization")
                let (retryData, retryResponse) = await performRequest(request)
                if let retryHttpResponse = retryResponse, retryHttpResponse.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let memberResponse = try decoder.decode(MemberResponse.self, from: retryData!)
                        return memberResponse.member
                    } catch {
                        print("Error decoding retry member response: \(error)")
                    }
                }
            }
        }
        
        print("Failed to fetch member. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
        return nil
    }
    
    func createMember(memberBody: MemberBody) async -> Member? {
        let urlString = baseURL + "/api/v1/loyalty/members"
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Keys.rbcKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "name": memberBody.name,
            "address": memberBody.address,
            "phone": memberBody.phone,
            "email": memberBody.email,
            "balance": memberBody.balance
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Failed to serialize request body.")
            return nil
        }
        
        request.httpBody = httpBody
        
        let (data, response) = await performRequest(request)
        
        if let httpResponse = response, httpResponse.statusCode == 200 {
            do {
                let decoder = JSONDecoder()
                let memberResponse = try decoder.decode(MemberResponse.self, from: data!)
                print("Member created \(memberResponse.member.id)")
                return memberResponse.member
            } catch {
                print("Error decoding member response: \(error)")
            }
        } else if let httpResponse = response, httpResponse.statusCode == 500 ||  httpResponse.statusCode == 403  {
            
            if await refreshToken() {
                request.setValue("Bearer \(Keys.rbcKey)", forHTTPHeaderField: "Authorization")
                let (retryData, retryResponse) = await performRequest(request)
                if let retryHttpResponse = retryResponse, retryHttpResponse.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let memberResponse = try decoder.decode(MemberResponse.self, from: retryData!)
                        return memberResponse.member
                    } catch {
                        print("Error decoding retry member response: \(error)")
                    }
                }
            }
        }
        
        print("Failed to create member. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
        return nil
    }
    
    func activateMember(memberId: Int) async -> Member? {
        let urlString = baseURL + "/api/v1/loyalty/members/\(memberId)"
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(Keys.rbcKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "status": "ACTIVE"
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Failed to serialize request body.")
            return nil
        }
        
        request.httpBody = httpBody
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                let memberResponse = try decoder.decode(MemberResponse.self, from: data)
                print("Member activated \(memberResponse.member.id)")
                return memberResponse.member

               
            } else {
                print("Failed to activate member. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return nil
            }
        } catch {
            print("Error activating member: \(error)")
            return nil
        }
    }
    
    func createTransaction(memberId: Int, transactionBody: TransactionBody) async -> Transaction? {
        let urlString = baseURL + "/api/v1/loyalty/\(memberId)/transactions"
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Keys.rbcKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "amount": transactionBody.amount,
            "note": transactionBody.note,
            "type": transactionBody.type,
            "partnerRefId": "INV-20234"
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Failed to serialize request body.")
            return nil
        }
        
        request.httpBody = httpBody
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                let transactionResponse = try decoder.decode(TransactionResponse.self, from: data)
                print("Transaction created \(transactionResponse.transaction.id)")
                return transactionResponse.transaction

               
            } else {
                print("Failed to create transaction. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return nil
            }
        } catch {
            print("Error creating transaction: \(error)")
            return nil
        }
    }

    func login() async -> String? {
        let urlString = baseURL + "/api/v1/auth"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "email": Keys.username,
            "password": Keys.password
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Failed to serialize request body")
            return nil
        }
        
        request.httpBody = httpBody
        
        let (data, response) = await performRequest(request)
        
        if let httpResponse = response, httpResponse.statusCode == 200 {
            do {
                let decoder = JSONDecoder()
                let loginResponse = try decoder.decode(LoginResponse.self, from: data!)
                Keys.rbcKey = loginResponse.accessToken
                return loginResponse.accessToken
            } catch {
                print("Error decoding login response: \(error)")
            }
        } else {
            print("Failed to login. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
        }
        return nil
    }
}

struct MemberResponse: Codable {
    let member: Member
}

struct Member: Codable {
    var id: Int
    var partnerId: Int
    var name: String
    var address: String
    var phone: String
    var email: String
    var balance: Int
    var status: String
    var createdAt: String
    var updatedAt: String
}

struct MemberBody {
    var name: String
    var address: String
    var phone: String
    var email: String
    var balance: Int
}

struct TransactionResponse: Codable {
    let transaction: Transaction
}

struct Transaction: Codable {
    var id: Int
    var partnerId: Int
    var memberId: Int
    var partnerRefId: String
    var reference: String
    var amount: Int
    var note: String
    var status: String
    var type: String
    var transactedAt: Date
    var createdAt: Date
    var updatedAt: Date
  }

struct TransactionBody{
    var amount: Int
    var note: String
    var type: String

struct LoginResponse: Codable {
    let accessToken: String
}
