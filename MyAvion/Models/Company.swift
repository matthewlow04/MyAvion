//
//  Company.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import Foundation

struct Company: Identifiable{
    var id = UUID()
    var name: String
    var address: String
    var coordinates: Coordinates
    var businessCategory: String
    var imageUrl: String
    
    enum sortType: String, CaseIterable{
        case distance = "Distance"
        case expiryDate = "Expiry Date"
        case mostPoints = "Most Points"
    }
    
    enum businessCategory: String, CaseIterable{
        case none
        case dining
        case entertainment
        case grocery
        case retail
    }
    
    var rewards: [Reward]
    var promotions: [Promotion]
}

struct Coordinates {
    var latitude: Double
    var longitude: Double
}

struct Reward: Identifiable{
    var id = UUID()
    var companyId: String
    var name: String
    var pointCost: Int
    var startDate: Date
    var expiryDate: Date
    var imageUrl: String
}

struct Promotion: Identifiable{
    var id = UUID()
    var companyID: String
    var name: String
    var points: Int
    var startDate: Date
    var endDate: Date
    var imageUrl: String
}

extension Company{
    static var mockCompanies: [Company] = [
        .init(name: "Campus Pizza", address: "160 University Ave W", coordinates: Coordinates(latitude: 43.4722, longitude: -80.5380), businessCategory: businessCategory.dining.rawValue, rewards: [], promotions: []),
        
        .init(name: "MyungGA Korean Restaurant", address: "256 Phillip St", coordinates: Coordinates(latitude: 43.4736, longitude: -80.5372), businessCategory: businessCategory.dining.rawValue, rewards: [], promotions: []),
        
            .init(name: "iPho Vietnamese Cuisine", address: "150 University Ave W", coordinates: Coordinates(latitude: 43.4727, longitude: -80.5360), businessCategory: businessCategory.dining.rawValue, rewards: [], promotions: []),
        
        .init(name: "Farah Foods", address: "256 Phillip St", coordinates: Coordinates(latitude: 43.44625, longitude: -80.5236), businessCategory: businessCategory.grocery.rawValue, rewards: [], promotions: []),
        
        .init(name: "Uniclaw", address: "140 University Ave W", coordinates: Coordinates(latitude: 43.4728, longitude: -80.5348), businessCategory: businessCategory.entertainment.rawValue, rewards: [], promotions: [])
    ]
}

struct FirebaseMember: Identifiable{
    var id = UUID()
    var memberId: String
    var nomination: NominatedCompany
    var approvedCompanies: [ApprovedCompany]
}

struct NominatedCompany: Identifiable{
    var id = UUID()
    var companyId: String
    var nominators: [Int]
}

struct ApprovedCompany: Identifiable{
    var id = UUID()
    var companyId: String
    var nominators: [Int]
}
