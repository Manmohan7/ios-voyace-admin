//
//  Authentication.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-10.
//

import SwiftUI
import Foundation
import FirebaseAuth

class Authentication: ObservableObject {
    @Published var loggedIn: Bool = false
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.loggedIn = true
                print("user is created")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            print("user logged in")
            
            if let err = error {
                print("Some error occurred", err)
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.loggedIn = true
                    print("queue updated", self.loggedIn)
                }
            }
        }
    }
}
