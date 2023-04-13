//
//  NoEntries.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-03-06.
//

import SwiftUI

struct NoEntries: View {
    @State var selection: Int? = nil
    
    var body: some View {
        VStack {
            Text("No entries found")
                .font(.system(size: 28))
                .padding(.bottom, 24)
                .foregroundColor(Color(UIColor.darkGray))
            
            NavigationLink(destination: AddHotel(), tag: 1, selection: $selection) {
                Button(action: {
                    self.selection = 1
                }, label: {
                    Text("+")
                })
                    .frame(width: 64, height: 64)
                    .font(.system(size: 32))
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
            }
        }
    }
}

struct NoEntries_Previews: PreviewProvider {
    static var previews: some View {
        NoEntries()
    }
}
