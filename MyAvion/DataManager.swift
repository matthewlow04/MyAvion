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
    
    func fetchCompanies(){
        companies.removeAll()
    }
    
    func fetchPromotions() async{
        promotions.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Promotions")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
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
            }
            
            print("fetch")
            print(self.promotions.count)
        }
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
}
