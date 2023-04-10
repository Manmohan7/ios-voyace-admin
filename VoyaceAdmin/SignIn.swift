//
//  SignIn.swift
//  VoyaceAdmin
//
//  Created by Shivani Bajaj on 2023-04-09.
//

import SwiftUI

struct SignIn: View {
  @State private var username: String = ""
  @State private var password: String = ""
  
  var body: some View {
    Form {
      HStack {
        Spacer()
        
        Image("voyage")
          .resizable()
          .frame(width: 150, height: 150, alignment: .center)
        
        Spacer()
      }
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)
      
      HStack {
        Spacer()
        
        Text("Sign In")
          .font(.system(size: 36))
        
        Spacer()
      }.listRowBackground(Color.clear)
      
      Section("Username") {
        TextField("manmohan7", text: $username)
      }
      
      Section("Password") {
        SecureField("******", text: $password)
      }
      
      Button("Sign In") {
        // sample action
      }
      .listRowBackground(Color.clear)
      .frame(maxWidth: .infinity, alignment: .center)
      .listRowSeparator(.hidden)
      
      HStack {
        Text("Don't have an account?")
        
        Button("Sign up") {
          // navigate to sign up view
        }
      }
      .listRowBackground(Color.clear)
      .frame(maxWidth: .infinity)
      
    }
  }
}

struct SignIn_Previews: PreviewProvider {
  static var previews: some View {
    SignIn()
  }
}
