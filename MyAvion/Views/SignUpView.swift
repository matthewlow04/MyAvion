//
//  SignUpView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var vm: LoginViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()

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
                vm.register()
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(vm.email.isEmpty || vm.password.isEmpty)

            Button(action: {
                vm.showingSignUp.toggle()
            }) {
                Text("Back to Login")
                    .underline()
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
    }
}

#Preview {
    SignUpView(vm: LoginViewModel())
}
