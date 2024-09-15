//
//  RBCManager.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-15.
//

import Foundation

class RBCManager: ObservableObject{
    @Published var member: [Reward] = []

    var baseURL = "https://paywithpretendpointsapi.onrender.com"
    
    func getMember(memberId: Int) async -> Member? {
        let urlString = baseURL + "/api/v1/loyalty/members/\(memberId)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(Keys.rbcKey)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                let memberResponse = try decoder.decode(MemberResponse.self, from: data)
                let member = memberResponse.member
                return member
            } else {
                print("Failed to fetch member. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        } catch {
            print("Error fetching member: \(error)")
        }
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
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                let memberResponse = try decoder.decode(MemberResponse.self, from: data)
                print("Member created \(memberResponse.member.id)")
                return memberResponse.member

               
            } else {
                print("Failed to create member. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return nil
            }
        } catch {
            print("Error creating member: \(error)")
            return nil
        }
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

struct MemberBody{
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
}
