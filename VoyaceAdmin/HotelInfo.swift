//
//  HotelInfo.swift
//  VoyaceAdmin
//
//  Created by Shivani Bajaj on 2023-04-09.
//

import SwiftUI

struct CardView: View{
  var body: some View{
    Rectangle()
      .fill(Color.pink)
      .frame(height: 200)
      .border(Color.black)
      .padding()
  }
}

struct Carousel: View {
  @State private var index = 0
  
  var body: some View {
    VStack {
      TabView(selection: $index) {
        ForEach((0..<3), id: \.self) { index in
          CardView()
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      
      HStack(spacing: 2) {
        ForEach((0..<3), id: \.self) { index in
          Rectangle()
            .fill(index == self.index ? Color.purple : Color.purple.opacity(0.5))
            .frame(height: 5)
        }
      }
      .padding()
    }
    .frame(height: 200)
  }
}



struct HotelInfo: View {
  var body: some View {
    Carousel()
  }
}

struct HotelInfo_Previews: PreviewProvider {
  static var previews: some View {
    HotelInfo()
  }
}
