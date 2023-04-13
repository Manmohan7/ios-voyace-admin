//
//  SignIn.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-09.
//

import SwiftUI

struct SignIn: View {
    @ObservedObject var Auth = Authentication()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    
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
                
                HStack {
                    Spacer()
                    
                    Text("Sign In")
                        .font(.system(size: 36))
                    
                    Spacer()
                }.listRowBackground(Color.clear)
                
                Section("Email") {
                    TextField("xyz@gmail.com", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section("Password") {
                    SecureField("******", text: $password)
                }
                
                Button("Sign In") {
                    Auth.signIn(email: email, password: password)
                }
                .fontWeight(.semibold)
                .listRowBackground(Color.clear)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(width: 300, height: 40)
                .listRowSeparator(.hidden)
                .padding([.bottom, .top], 6)
                .padding([.leading, .trailing], 12)
                .background(CustomColor.darkGreen)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                
                HStack {
                    Text("Don't have an account?")
                    
                    Text("Sign Up")
                        .foregroundColor(.blue)
                        .background( NavigationLink("", destination: SignUp()).opacity(0) )
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

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
