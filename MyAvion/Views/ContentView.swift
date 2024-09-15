//
//  ContentView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack {
            if let user = loginViewModel.user {
                TabView {
                    HomeView(user: $loginViewModel.user) 
                        .tabItem { Label("Home", systemImage: "house.fill") }
                    Text("")
                        .tabItem { Label("Travel", systemImage: "map") }
                    ExploreView()
                        .tabItem { Label("Offers", systemImage: "magnifyingglass") }
                    Text("")
                        .tabItem { Label("Redeem", systemImage: "star") }
                    Text("")
                        .tabItem { Label("More", systemImage: "line.3.horizontal") }
                    TestView()
                        .tabItem { Label("Test", systemImage: "testtube.2") }
                }
            } else {
                LoginView(vm: loginViewModel)
            }
        }
        .onAppear {
            loginViewModel.user = Auth.auth().currentUser
            Task{
                await dataManager.fetchCompanies()
                await dataManager.fetchRewards()
                await dataManager.fetchPromotions()
            }
        }
        .animation(.easeInOut, value: loginViewModel.user != nil)
    }
}

#Preview {
    ContentView()
}
