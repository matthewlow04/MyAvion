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
    @EnvironmentObject var rbcManager: RBCManager
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
            
            Button("Create Member"){
                Task{
                    if let member = await rbcManager.createMember(memberBody: MemberBody(name: "aassa", address: "dfa", phone: "dfasd", email: "matthewtest123@gmail.com", balance: 12)){
                        
                        if let memberFetch = await rbcManager.getMember(memberId: member.id){
                            print(memberFetch.name)
                        }
                    }

                }
            }
            Button("Fetch Member"){
                Task{
                    if let member = await rbcManager.getMember(memberId: 520){
                        dump(member)
                    }
                }
            }
        }
        
    }
}

#Preview {
    TestView()
}
