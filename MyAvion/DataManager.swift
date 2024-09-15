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
    
    // FETCH
    //
    func addRewards(companyID: String, name: String, pointCost: Int, startDate: Date, expiryDate: Date){
        let db = Firestore.firestore()
        let id = UUID()
        
        let ref = db.collection("Rewards").document(name)
        ref.setData(["id": id.uuidString, "name":name, "pointCost":pointCost, "companyId":companyID, "startDate": Timestamp(date: startDate), "expiryDate": Timestamp(date: expiryDate)]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchRewards() async{
        rewards.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Rewards")
        
        do {
            let snapshot = try await ref.getDocuments()
            for document in snapshot.documents{
                let data = document.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let pointCost = data["points"] as? Int ?? -1
                let companyId = data["companyID"] as? String ?? ""
                let startDate = data["startDate"] as? Timestamp ?? Timestamp(date: Date.now)
                let expiryDate = data["startDate"] as? Timestamp ?? Timestamp(date: Date.now)
                
                
                let reward = Reward(id: UUID(uuidString: id)!, companyId: companyId, name: name, pointCost: pointCost, startDate: startDate.dateValue(), expiryDate: expiryDate.dateValue())
                self.rewards.append(reward)
            }
        } catch {
            print("error")
        }

        print("fetch")
        print(self.rewards.count)
    }
    
    func fetchCompanies(){
        companies.removeAll()
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
                
                
                let promotion = Promotion(id: UUID(uuidString: id)!, companyId: companyID, name: name, points: points, startDate: startDate.dateValue(), endDate: endDate.dateValue())
                self.promotions.append(promotion)
            }
        } catch {
            print("error")
        }

        print("fetch")
        print(self.promotions.count)
    }

    
    func addPromotions(companyID: String, name: String, points: Int, startDate: Date, endDate: Date){
        let db = Firestore.firestore()
        let id = UUID()
        
        let ref = db.collection("Promotions").document(name)
        ref.setData(["id": id.uuidString, "name":name, "points":points, "companyID":companyID, "startDate": Timestamp(date: startDate), "endDate": Timestamp(date: endDate)]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    func addCompany(name: String, address: String, coordinates: Coordinates, businessCategory: String){
        let db = Firestore.firestore()
        let id = UUID()
        let coordinatesDict = ["latitude": coordinates.latitude, "longitude": coordinates.longitude]
        
        let ref = db.collection("Companies").document(name)
        ref.setData(["id": id.uuidString, "name":name, "address":address, "coordinates":coordinatesDict, "businessCategory": businessCategory]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
}
