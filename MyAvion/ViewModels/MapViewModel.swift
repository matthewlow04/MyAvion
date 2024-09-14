//
//  MapViewModel.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import Foundation
import MapKit


class MapViewModel: ObservableObject{
    @Published var selectedCategory: Location.LocationCategory = .entertainment
    var filteredLocations: [Location]{
        switch selectedCategory {
        case .dining:
            return Location.mockLocations.filter{$0.category == .dining}
        case .entertainment:
            return Location.mockLocations.filter{$0.category == .entertainment}
        case .grocery:
            return Location.mockLocations.filter{$0.category == .grocery}
        case .retail:
            return Location.mockLocations.filter{$0.category == .retail}
            
        }
    }
    
    
}
