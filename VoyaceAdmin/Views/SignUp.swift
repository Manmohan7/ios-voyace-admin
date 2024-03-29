//
//  SignUp.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-09.
//

import SwiftUI

struct SignUp: View {
    @ObservedObject var Auth = Authentication()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var cPassword: String = ""
    
    var body: some View {
        NavigationView {
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
                
                Section("Email") {
                    TextField("xyz@gmail.com", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section("Password") {
                    SecureField("*******", text: $password)
                }
                
                Section("Confirm Password") {
                    SecureField("*******", text: $cPassword)
                }
                
                Button("Sign Up") {
                    guard password == cPassword else {
                        print("password do not match")
                        return
                    }
                    
                    Auth.signUp(email: email, password: password)
                }
                .fontWeight(.semibold)
                .listRowBackground(Color.clear)
                .frame(maxWidth: .infinity)
                .frame(width: 300, height: 40)
                .listRowSeparator(.hidden)
                .padding([.bottom, .top], 6)
                .padding([.leading, .trailing], 12)
                .background(CustomColor.darkGreen)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                HStack {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .foregroundColor(.blue)
                        .background( NavigationLink("", destination: SignIn()).opacity(0) )
                }
                .listRowBackground(Color.clear)
                .frame(maxWidth: .infinity)

                
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $Auth.loggedIn) {
            ListHotels()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
