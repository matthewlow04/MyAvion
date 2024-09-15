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
    var imageUrl: String
}

struct Promotion: Identifiable{
    var id = UUID()
    var companyId: String
    var name: String
    var points: Int
    var startDate: Date
    var endDate: Date
    var imageUrl: String
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
    var nominators: [FirebaseMember]
}

struct ApprovedCompany: Identifiable{
    var id = UUID()
    var companyId: String
    var nominators: [FirebaseMember]
}
