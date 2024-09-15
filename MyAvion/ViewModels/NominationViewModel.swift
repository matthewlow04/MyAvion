//
//  NominationViewModel.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-15.
//

import SwiftUI

class NominateCompanyViewModel: ObservableObject {
    @Published var companyName: String = ""
    @Published var address: String = ""
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published var businessCategory: String = Company.businessCategory.none.rawValue
    @Published var showingAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    

    func clearFields() {
        companyName = ""
        address = ""
        latitude = ""
        longitude = ""
        businessCategory = Company.businessCategory.none.rawValue
    }
    
    func isFormValid() -> Bool {
        if companyName.isEmpty || address.isEmpty || latitude.isEmpty || longitude.isEmpty || businessCategory == Company.businessCategory.none.rawValue {
            alertTitle = "Incomplete Form"
            alertMessage = "Please fill out all required fields."
            showingAlert = true
            return false
        }
        
        guard let lat = Double(latitude), let long = Double(longitude) else {
            alertTitle = "Invalid Coordinates"
            alertMessage = "Please enter valid numeric values for latitude and longitude."
            showingAlert = true
            return false
        }
        
        if lat < -90 || lat > 90 || long < -180 || long > 180 {
            alertTitle = "Invalid Coordinates"
            alertMessage = "Latitude must be between -90 and 90, and longitude must be between -180 and 180."
            showingAlert = true
            return false
        }
        
        return true
    }
    
    func nominateCompany() {
        guard isFormValid() else { return }
        
        let coordinates = Coordinates(latitude: Double(latitude)!, longitude: Double(longitude)!)
        
        let company = Company(name: companyName, address: address, coordinates: coordinates, businessCategory: businessCategory, rewards: [], promotions: [])
        let nominatedCompany = NominatedCompany(companyId: company.id.uuidString, nominators: [])
        
        alertTitle = "Success"
        alertMessage = "\(companyName) has been successfully nominated!"
        showingAlert = true
        
        clearFields()
    }
}
