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
                            ForEach(0..<2) { _ in
                                OfferView()
                            }
                        }
                        .padding()
                    }

                    Text("Shop Offers")
                        .font(.largeTitle)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(0..<2) { _ in
                                OfferView()
                            }
                        }
                        .padding()
                    }
                    
                    Text("Community")
                        .font(.largeTitle)
                    
                    MapView()
                }
                .padding()
                .navigationTitle("12,300 pts")
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
