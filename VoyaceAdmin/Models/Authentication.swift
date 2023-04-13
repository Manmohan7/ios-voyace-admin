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
    
    let defaults = UserDefaults.standard
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.loggedIn = true
                self.defaults.set(authResult?.user.email, forKey: "email")
                self.defaults.set(authResult?.user.uid, forKey: "uid")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print("Some error occurred", err)
                return
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.loggedIn = true
                    self.defaults.set(authResult?.user.email, forKey: "email")
                    self.defaults.set(authResult?.user.uid, forKey: "uid")
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                withAnimation {
                    self.loggedIn = false
                    self.defaults.removeObject(forKey: "email")
                    self.defaults.removeObject(forKey: "uid")
                }
            }
        } catch {
            print("Some error in signing out")
        }
    }
}
