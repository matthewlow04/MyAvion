//
//  DataManager.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import Foundation
import Firebase

class DataManager: ObservableObject{
    @Published var companies: [Company] = []
    @Published var rewards: [Reward] = []
    @Published var promotions: [Promotion] = []
    @Published var idConnections: [IdConnection] = []
    
    func addRewards(companyID: String, name: String, pointCost: Int, startDate: Date, expiryDate: Date, imageUrl: String){
        let db = Firestore.firestore()
        let id = UUID()
        
        let ref = db.collection("Rewards").document(name)
        ref.setData(["id": id.uuidString, "name":name, "pointCost":pointCost, "companyId":companyID, "startDate": Timestamp(date: startDate), "expiryDate": Timestamp(date: expiryDate), "imageUrl": imageUrl]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchRewards() async {
        DispatchQueue.main.async {
            self.rewards.removeAll()
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("Rewards")
        
        do {
            let snapshot = try await ref.getDocuments()
            var fetchedRewards: [Reward] = []
            
            for document in snapshot.documents {
                let data = document.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let pointCost = data["points"] as? Int ?? -1
                let companyId = data["companyId"] as? String ?? ""
                let startDate = data["startDate"] as? Timestamp ?? Timestamp(date: Date())
                let expiryDate = data["expiryDate"] as? Timestamp ?? Timestamp(date: Date())
                let imageUrl = data["imageUrl"] as? String ?? ""
                
                let reward = Reward(
                    id: UUID(uuidString: id) ?? UUID(),
                    companyId: companyId,
                    name: name,
                    pointCost: pointCost,
                    startDate: startDate.dateValue(),
                    expiryDate: expiryDate.dateValue(),
                    imageUrl: imageUrl
                )
                fetchedRewards.append(reward)
            }
            
            DispatchQueue.main.async {
                self.rewards = fetchedRewards
            }
            
        } catch {
            print("Error fetching rewards: \(error.localizedDescription)")
        }
    }

    func fetchCompanies() async {
        DispatchQueue.main.async {
            self.companies.removeAll()
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("Companies")
        
        do {
            let snapshot = try await ref.getDocuments()
            var fetchedCompanies: [Company] = []
            
            for document in snapshot.documents {
                let data = document.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let coordinatesData = data["coordinates"] as? [String: Double] ?? [:]
                let coordinates = Coordinates(
                    latitude: coordinatesData["latitude"] ?? 0.0,
                    longitude: coordinatesData["longitude"] ?? 0.0
                )
                let businessCategory = data["businessCategory"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String ?? ""
                
                let rewards: [Reward] = []
                let promotions: [Promotion] = []
                let company = Company(
                    id: UUID(uuidString: id) ?? UUID(),
                    name: name,
                    address: address,
                    coordinates: coordinates,
                    businessCategory: businessCategory,
                    imageUrl: imageUrl,
                    rewards: rewards,
                    promotions: promotions
                )
                fetchedCompanies.append(company)
            }
            
            DispatchQueue.main.async {
                self.companies = fetchedCompanies
            }
            
        } catch {
            print("Error fetching companies: \(error.localizedDescription)")
        }
        
        print("Fetched companies count: \(self.companies.count)")
    }

    
    func fetchCompanyById(companyId: String) -> Company? {
        print(companyId)

        return companies.first { $0.id.uuidString == companyId }
    }

    func fetchPromotions() async{
        promotions.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Promotions")
        
        do {
            let snapshot = try await ref.getDocuments()
            for document in snapshot.documents{
                let data = document.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let points = data["points"] as? Int ?? -1
                let companyID = data["companyID"] as? String ?? ""
                let startDate = data["startDate"] as? Timestamp ?? Timestamp(date: Date.now)
                let endDate = data["startDate"] as? Timestamp ?? Timestamp(date: Date.now)
                let imageUrl = data["imageUrl"] as? String ?? ""
                
                
                let promotion = Promotion(id: UUID(uuidString: id)!, companyID: companyID, name: name, points: points, startDate: startDate.dateValue(), endDate: endDate.dateValue(), imageUrl: imageUrl)
                self.promotions.append(promotion)
            }
        } catch {
            print("error")
        }
        
        print("promtions")
        print(self.promotions)
    }
    
    
    func addPromotions(companyId: String, name: String, points: Int, startDate: Date, endDate: Date, imageUrl: String){
        let db = Firestore.firestore()
        let id = UUID()
        
        let ref = db.collection("Promotions").document(name)
        ref.setData(["id": id.uuidString, "name":name, "points":points, "companyID":companyId, "startDate": Timestamp(date: startDate), "endDate": Timestamp(date: endDate), "imageUrl": imageUrl]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    func addCompany(name: String, address: String, coordinates: Coordinates, businessCategory: String, imageUrl: String){
        let db = Firestore.firestore()
        let id = UUID()
        let coordinatesDict = ["latitude": coordinates.latitude, "longitude": coordinates.longitude]
        
        let ref = db.collection("Companies").document(id.uuidString)
        ref.setData(["id": id.uuidString, "name":name, "address":address, "coordinates":coordinatesDict, "businessCategory": businessCategory, "imageUrl": imageUrl, "rewards": [], "promotions": []]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    func addRewardToCompany(companyId: String, rewardId: String){
        let db = Firestore.firestore()
        let ref = db.collection("Companies").document(companyId)
        
        ref.updateData(["rewards": FieldValue.arrayUnion([rewardId])])
    }
    
    func addPromotionToCompany(companyId: String, promotionId: String){
        let db = Firestore.firestore()
        let ref = db.collection("Companies").document(companyId)
        
        ref.updateData(["promotions": FieldValue.arrayUnion([promotionId])])
    }
    
    func addConnection(idConnection: IdConnection){
        let db = Firestore.firestore()
        let ref = db.collection("Connections").document(idConnection.firebaseID)
        ref.setData(["RbcId" : idConnection.rbcID, "FirebaseId": idConnection.firebaseID]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }

    func fetchRbcID(firebaseID: String) async -> Int? {
        let db = Firestore.firestore()
        let ref = db.collection("Connections").document(firebaseID)
        
        do {
            let document = try await ref.getDocument()
            
            if let data = document.data(){
               let rbcID = data["RbcId"] as? Int
               return rbcID
            } else {
                print("Document does not exist or rbcId not found")
                return nil
            }
        } catch {
            print("Error fetching document: \(error.localizedDescription)")
            return nil
        }
    }

}
