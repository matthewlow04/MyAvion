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
            Button("Add Promotion"){
                dataManager.addPromotions(companyID: "AB1234", name: "Starbucks", points: 100, startDate: Date.now, endDate: Date.now)
            }
            Button("Fetch Promotion"){
                Task{
                    await dataManager.fetchPromotions()
                    for promotion in dataManager.promotions {
                        print(promotion.name)
                    }
                }
                
            }
        }
        
    }
}

#Preview {
    TestView()
}
