//
//  Location.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import Foundation
import MapKit

struct Location: Identifiable{
    let id = UUID()
    var name: String
    var category: LocationCategory
    var coordinate: CLLocationCoordinate2D
    
    enum LocationCategory: String, CaseIterable{
        case dining
        case entertainment
        case grocery
        case retail
    }
}

extension Location{
    static var mockLocations: [Location] = [
        .init(name: "E7", category: .entertainment, coordinate: CLLocationCoordinate2D(latitude: 43.4730, longitude: -80.5395)),
        .init(name: "Campus Pizza", category: .dining, coordinate: CLLocationCoordinate2D(latitude: 43.4722, longitude: -80.5380)),
        .init(name: "Icon", category: .entertainment, coordinate: CLLocationCoordinate2D(latitude: 43.4765, longitude: -80.5391))
    ]
    
}
