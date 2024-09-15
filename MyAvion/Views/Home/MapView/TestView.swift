//
//  TestView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI

//TODO
struct TestView: View {
    @EnvironmentObject var dataManager: DataManager
    var body: some View {
        VStack{
            Text("Promotions")
                .font(.system(size: 20))
            Button("Add Promotion"){
                dataManager.addPromotions(companyID: "ZZ3451", name: "Lazeez", points: 50, startDate: Date.now, endDate: Date.now)
            }
            Button("Fetch Promotion"){
                Task{
                    await dataManager.fetchPromotions()
                    for promotion in dataManager.promotions {
                        print(promotion.name)
                    }
                }
            }
            Text("Rewards")
                .font(.system(size: 20))
            Button("Add Reward"){
                dataManager.addRewards(companyID: "ZZ3451", name: "Free Medium Shawarma", points: 600, startDate: Date.now, expiryDate: Date.now)
            }
        }
        
    }
}

#Preview {
    TestView()
}
