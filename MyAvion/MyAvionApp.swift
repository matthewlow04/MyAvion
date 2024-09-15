//
//  MyAvionApp.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI
import Firebase

@main
struct MyAvionApp: App {
    @StateObject var rbcManager = RBCManager()
    @StateObject var dataManager = DataManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
                .environmentObject(rbcManager)
        }
    }
}
