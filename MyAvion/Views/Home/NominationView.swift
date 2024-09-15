//
//  NominationView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-15.
//

import SwiftUI


struct NominateCompanyView: View {
    @StateObject var vm = NominateCompanyViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Group {
                        HStack(spacing: 2) {
                            Text("Company Name")
                            Text(vm.companyName.isEmpty ? "*" : "")
                                .foregroundStyle(.red)
                        }
                        TextField("Company Name", text: $vm.companyName)
                            .modifier(FormTextfieldModifier())
                            .padding(.horizontal, 2)
                            .autocorrectionDisabled()
                            .onChange(of: vm.companyName) { oldValue, newValue in
                                if newValue.count > 20 {
                                    vm.companyName = String(newValue.prefix(20))
                                }
                            }
                    }
                    
                    Group {
                        HStack(spacing: 2) {
                            Text("Address")
                            Text(vm.address.isEmpty ? "*" : "")
                                .foregroundStyle(.red)
                        }
                        TextField("Address", text: $vm.address)
                            .modifier(FormTextfieldModifier())
                            .padding(.horizontal, 2)
                            .autocorrectionDisabled()
                    }
                    
                    Group {
                        HStack {
                            Text("Coordinates (Latitude, Longitude)")
                        }
                        HStack {
                            TextField("Latitude", text: $vm.latitude)
                                .modifier(FormTextfieldModifier())
                                .padding(.horizontal, 2)
                                .keyboardType(.decimalPad)
                            
                            TextField("Longitude", text: $vm.longitude)
                                .modifier(FormTextfieldModifier())
                                .padding(.horizontal, 2)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    // Business Category
                    Group {
                        HStack(spacing: 2) {
                            Text("Business Category")
                            Text(vm.businessCategory.isEmpty ? "*" : "")
                                .foregroundStyle(.red)
                        }
                        Picker("Business Category", selection: $vm.businessCategory) {
                            ForEach(Company.businessCategory.allCases, id: \.self) { category in
                                Text(category.rawValue.capitalized).tag(category.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Spacer()
                    
                    Button {
                        vm.nominateCompany()
                    } label: {
                        Text("Nominate Company")
                            .modifier(ConfirmButtonModifier())
                            .padding(.vertical)
                    }
                    HStack{
                        Spacer()
                        Button("Back"){
                            dismiss()
                        }
                        Spacer()
                    }
                    
                }
                .padding(.horizontal)
                .navigationTitle("Nominate Company")
                .alert(isPresented: $vm.showingAlert) {
                    Alert(
                        title: Text(vm.alertTitle),
                        message: Text(vm.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .onDisappear {
                    vm.clearFields()
                }
            }
        }
    }
}

#Preview {
    NominateCompanyView()
}

