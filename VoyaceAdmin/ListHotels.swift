//
//  ListHotels.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-03-06.
//

import SwiftUI

struct ListHotels: View {
    var body: some View {
        NavigationView {
            Text("Hello, List!")
            
            // TODO: get data from firebase and display as a list
            List {
                
            }
        }.navigationBarBackButtonHidden()
    }
}

struct ListHotels_Previews: PreviewProvider {
    static var previews: some View {
        ListHotels()
    }
}
