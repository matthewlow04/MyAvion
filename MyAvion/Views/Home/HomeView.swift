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
    @State var rbcId: Int?
    @State var isLoadingPoints = false
    @State var isShowingNomination = false
    @State var isShowingNominationList = false
    @State var isShowingOffer = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Avion Rewards")
                            .font(.system(size: 20))
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 30, height: 30)
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

                            ForEach(0..<2) { _ in
                                Button {
                                    isShowingOffer = true
                                } label: {
                                    OfferView()
                                }
                                
                            }
                            .foregroundStyle(.foreground)
                        }
                        .padding()
                        
                        

                        
                    }
                    
                    Text("Community")
                        .font(.largeTitle)
                    
                    MapView()
                    
                    Button(action: {
                        isShowingNomination = true
                    }, label: {
                        Text("Nominate A Company")
                            .modifier(ConfirmButtonModifier())
                    })
                    .padding(.vertical)
                    
                    Button(action: {
                        isShowingNominationList = true
                    }, label: {
                        Text("View Nominated Companies")
                            .modifier(ConfirmButtonModifier())
                    })
                    .padding(.vertical)
                    

                }
                .padding()
                .navigationTitle(Text("\(balance ?? 0) points"))
                .fullScreenCover(isPresented: $isShowingNomination, content: {
                    NominateCompanyView()
                })
                .fullScreenCover(isPresented: $isShowingNominationList, content: {
                    NominateCompanyListView()
                })
                .sheet(isPresented: $isShowingOffer, content: {
                    VStack(alignment: .leading, spacing: 20){
                        Text("Redeem Offer")
                            .font(.system(size: 30))
                        OfferView()
                        if isLoadingPoints{
                            ProgressView()
                        } else {
                            Button(action: {
                                Task{
                                    isLoadingPoints = true
                                    await rbcManager.getMember(memberId:rbcId ?? 0)
                                    await rbcManager.createTransaction(memberId: rbcId ?? 0, transactionBody: TransactionBody(amount: -100, note: "asdfad", type: "PAYMENT"))
                                    isLoadingPoints = false
                                }
                            }, label: {
                                Text("Redeem Now")
                                    .modifier(ConfirmButtonModifier())
                                    .frame(width: 300)
                            })
                        }
                        
                        
                        
                      
                    }
                   
                
                })
                .onAppear{
                    Task{
                        await dataManager.fetchCompanies()
                        isLoadingPoints = true
                        if let rbcID = await dataManager.fetchRbcID(firebaseID: user?.uid ?? ""){
                            rbcId = rbcID
                                                        
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


