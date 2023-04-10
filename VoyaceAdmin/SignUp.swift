//
//  SignUp.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-09.
//

import SwiftUI

struct SignUp: View {
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var cPassword: String = ""
  
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
      
      Text("Sign Up")
        .font(.system(size: 36))
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
      
      Section("Username") {
        TextField("manmohan7", text: $username)
      }
      
      Section("Password") {
        SecureField("*******", text: $password)
      }
      
      Section("Confirm Password") {
        SecureField("*******", text: $cPassword)
      }
      
      Button("Sign Up") {
        print("save the data")
      }
      .listRowBackground(Color.clear)
      .frame(maxWidth: .infinity)
      
    }
  }
}

struct SignUp_Previews: PreviewProvider {
  static var previews: some View {
    SignUp()
  }
}
