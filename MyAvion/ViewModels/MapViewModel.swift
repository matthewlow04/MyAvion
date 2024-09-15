//
//  MapViewModel.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import Foundation
import MapKit
import SwiftUI


class MapViewModel: ObservableObject{
    @Published var selectedCategory: Company.businessCategory = .none
    @Published var selectedSortOption: Company.sortType = .expiryDate
    var companies: [Company] = []
    var filteredCompanies: [Company]{
        switch selectedCategory {
        case .none:
            return Company.mockCompanies
        case .dining:
            return Company.mockCompanies.filter{$0.businessCategory == Company.businessCategory.dining.rawValue}
        case .entertainment:
            return Company.mockCompanies.filter{$0.businessCategory == Company.businessCategory.entertainment.rawValue}
        case .grocery:
            return Company.mockCompanies.filter{$0.businessCategory == Company.businessCategory.grocery.rawValue}
        case .retail:
            return Company.mockCompanies.filter{$0.businessCategory == Company.businessCategory.retail.rawValue}
            
        }
    }
    
    var sortedCompanies: [Company] {
        switch selectedSortOption {
        case .distance:
            return filteredCompanies
        case .expiryDate:
            return filteredCompanies
            
        case .mostPoints:
            return filteredCompanies
        }
    }
    
    
}
