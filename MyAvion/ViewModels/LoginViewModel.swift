//
//  LoginViewModel.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import Foundation
import Firebase
import FirebaseAuth
import RegexBuilder

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showingAlert = false
    @Published var showingSignUp = false
    @Published var user: User?
    @Published var isLoading = false

    var alertMessage = ""

    func login() {
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
                self.isLoading = false
                return
            }

            if let result = result {
                self.user = result.user
            }
            self.isLoading = false
        }
    }

    func register() {
        if !validEmailAddress(){
            alertMessage = "Enter a valid email"
            showingAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
                return
            }

            if result != nil {
                self.showingSignUp = false
                self.alertMessage = "User Created"
                self.showingAlert = true
            }
        }
    }
    
    func invalidLogin() -> Bool{
        if !validEmailAddress(){
            return false
        }
        
        if password.isEmpty{
            return false
        }
        
        return true
    }
    
    func validEmailAddress() -> Bool{
        let pattern = Regex {
            OneOrMore(.word)
            "@"
            OneOrMore(.word)
            "."
            Repeat(2...3){
                .word
            }
        }
        
        if (email.wholeMatch(of: pattern) != nil) {
            return true
        }
        return false
    }
}
