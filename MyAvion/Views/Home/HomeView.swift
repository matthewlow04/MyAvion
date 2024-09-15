//
//  HomeView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @Binding var user: User? 
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var rbcManager: RBCManager
    @State var balance: Int?
    @State var isLoadingPoints = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Avion Rewards")
                            .font(.system(size: 20))
                        Spacer()
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                logout()
                            }
                    }
                    
                    Text("For You")
                        .font(.largeTitle)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(dataManager.rewards) { reward in
                                let company = dataManager.fetchCompanyById(companyId: reward.companyId)
                                OfferView(logo: reward.imageUrl, image: reward.imageUrl, name: company?.name ?? "", description: reward.name, time: "2 days")
                            }
                        }
                        .padding()
                    }

                    Text("Shop Offers")
                        .font(.largeTitle)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(dataManager.promotions) { promotion in
                                let company = dataManager.fetchCompanyById(companyId: promotion.companyID)
                                OfferView(logo: promotion.imageUrl, image: promotion.imageUrl, name: company?.name ?? "", description: promotion.name, time: "2 days")
                            }
                        }
                        .padding()
                    }
                    
                    Text("Community")
                        .font(.largeTitle)
                    
                    MapView()
                }
                .padding()
                .navigationTitle(Text("\(balance ?? 0) points"))
                .onAppear{
                    Task{
                        isLoadingPoints = true
                        if let rbcID = await dataManager.fetchRbcID(firebaseID: user?.uid ?? ""){
                                                        
                            if let member = await rbcManager.getMember(memberId: rbcID){
                                balance = member.balance
                            }
                            
                        }
                        isLoadingPoints = false
                    }
                   

                }
                
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HomeView(user: .constant(nil))
}
