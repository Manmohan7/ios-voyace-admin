//
//  HotelInfo.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-09.
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
    private var images = [String]()
    
    init(images: [String]) {
        self.index = index
        self.images = images
    }
    
    var body: some View {
        VStack {
            TabView(selection: $index) {
                ForEach(0..<images.count, id: \.self) { index in
                    AsyncImage(url: URL(string: images[index])) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200, alignment: .center)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 2) {
                ForEach((0..<images.count), id: \.self) { index in
                    Rectangle()
                        .fill(index == self.index ? Color.purple : Color.purple.opacity(0.5))
                        .frame(height: 5)
                }
            }
        }
        .frame(height: 200)
    }
}


struct HotelInfo: View {
    var hotel: Hotel
    
    init(hotel: Hotel) {
        self.hotel = hotel
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Carousel(images: hotel.images)
                    .padding(.bottom)
                
                Text(hotel.name)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(hotel.location)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Text(hotel.description)
                    .padding(.top)
                
                Divider().padding()
                
                Text("Rooms Available")
                    .font(.title)
                    .padding(.bottom)
                
                Section {
                    ForEach(0..<hotel.rooms!.count, id: \.self) { index in
                        let room = hotel.rooms![index]
                        
                        HStack {
                            Text("\(index + 1).")
                            Text(room.roomName)
                        }
                        Text("Fare - $\(room.roomFare) per night")
                            .padding(.bottom, 10)
                    }
                }
                
                Spacer()
            }.padding()
        }.navigationTitle("Hotel Info")
    }
}

struct HotelInfo_Previews: PreviewProvider {
    static var previews: some View {
        HotelInfo(hotel: Hotel(name: "Long long long long Hotel name", description: "lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor", location: "Barrie", images: ["https://firebasestorage.googleapis.com:443/v0/b/ios-voyace-admin.appspot.com/o/hotelImages%2FYnxqhIdqDlQfOarliZXHPC22jTs1408B358A-6139-4720-B60A-7BF4B148825E?alt=media&token=5811cbe1-bbe2-4869-b6de-3d49b5882744", "https://firebasestorage.googleapis.com:443/v0/b/ios-voyace-admin.appspot.com/o/hotelImages%2FYnxqhIdqDlQfOarliZXHPC22jTs19CE8DF45-E617-494C-8668-0FD97BAE99F3?alt=media&token=1e55bb75-7012-43d1-aa60-df3a8649e414"], rooms: [Room(roomName: "Premium", roomFare: "50"), Room(roomName: "Deluxe", roomFare: "150")]))
    }
}
