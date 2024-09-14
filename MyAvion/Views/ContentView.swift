//
//  ContentView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            Text("")
                .tabItem { Label("Travel", systemImage: "map") }
            ExploreView()
                .tabItem{ Label("Offers", systemImage: "magnifyingglass") }
            Text("")
                .tabItem { Label("Redeem", systemImage: "star") }
            Text("")
                .tabItem { Label("More", systemImage: "line.3.horizontal") }            
        }
    }
}

#Preview {
    ContentView()
}
