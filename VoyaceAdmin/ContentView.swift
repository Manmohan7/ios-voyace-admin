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
            SignIn()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .leading))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
