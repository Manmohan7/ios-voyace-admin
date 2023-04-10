//
//  ContentView.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-03-06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
//            VStack {
                // add condition to check if there is some existing data
//                if(!true) {
//                    // data exists then display it in a table format
//                    ListHotels()
//                } else {
//                    NoEntries()
//                }
              
              SignUp()
//            }
//            .padding()
        }.navigationTitle("Home shyd")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
