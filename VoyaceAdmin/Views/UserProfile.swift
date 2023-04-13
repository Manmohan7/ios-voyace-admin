//
//  UserProfile.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-13.
//

import SwiftUI

struct UserProfile: View {
    @State var logout = false
    
    let email = UserDefaults.standard.string(forKey: "email") ?? "Email not found!"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello there user!")
                .font(.title)
            
            Text("Email: \(email)")
                .font(.title2)
            
            Button(action: {
                Authentication().signOut()
                self.logout = true
            }, label: {
                Text("Sign Out")
                    .font(.title3)
            })
            .padding([.bottom, .top], 12)
            .padding([.leading, .trailing], 36)
            .background(CustomColor.darkGreen)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .navigationTitle("User Profile")
        .navigationDestination(isPresented: $logout) {
            SignIn()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
