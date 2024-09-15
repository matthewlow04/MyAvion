//
//  LoginView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI

import SwiftUI

struct LoginView: View {
    @StateObject var vm: LoginViewModel

    var body: some View {
        VStack(spacing: 20) {
            if vm.isLoading{
                ProgressView("Checking Login")
            } else {
                Text("Avion Rewards")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)

                TextField("Email", text: $vm.email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $vm.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Button(action: {
                    vm.login()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!vm.invalidLogin())
                .opacity(!vm.invalidLogin() ? 0.3 : 1.0)
                

                Button(action: {
                    vm.showingSignUp.toggle()
                }) {
                    Text("Create New Account")
                        .underline()
                }
            }
        }
        .padding()
        .alert(isPresented: $vm.showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(vm.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $vm.showingSignUp) {
            SignUpView(vm: vm)
        }
    }
}

