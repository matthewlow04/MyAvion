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
}

struct Promotion: Identifiable{
    var id = UUID()
    var companyId: String
    var name: String
    var points: Int
    var startDate: Date
    var endDate: Date
}
