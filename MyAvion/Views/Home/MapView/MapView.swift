//
//  MapView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @StateObject var vm = MapViewModel()
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        VStack {
            Map(position: $position) {
                ForEach(dataManager.companies) { company in
                    
                    Marker(company.name, coordinate: CLLocationCoordinate2D(latitude: company.coordinates.latitude, longitude: company.coordinates.longitude))
                        
                }
            }
            .frame(height: 400)
            .onAppear {
                CLLocationManager().requestWhenInUseAuthorization()
            }
            .mapControls {
                MapUserLocationButton()
            }
            .mapStyle(.imagery)
            
            Divider()
            
            HStack{
                Menu {
                    Picker("Filter Options", selection: $vm.selectedCategory) {
                        ForEach(Location.LocationCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    }
                }
                label: {
                    VStack{
                        Text("Sort Type")
                    }
                    
                }
                Menu {
                    Picker("Sorting Options", selection: $vm.selectedCategory) {
                        ForEach(Location.LocationCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    }
                }
                label: {
                    VStack{
                        Text("Sort Type")
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            

            VStack(spacing: 20){
                ForEach(dataManager.companies){ company in
                    CompanyView(company: company)
                    
                }
            }
            
        }
        .onAppear{
            vm.companies = dataManager.companies
        }
    }
}

#Preview {
    MapView()
}
