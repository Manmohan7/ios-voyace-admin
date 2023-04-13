//
//  ListHotels.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-03-06.
//

import SwiftUI

struct ListHotels: View {
    let defaults = UserDefaults.standard
    
    @StateObject var hotelDB = HotelsDB()
    @State var addHotel = false
    @State var userProfile: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        if (hotelDB.hotels.isEmpty) {
                            Text("Start by adding new hotel!")
                                .padding(.top, (geometry.size.height / 2) - 50)
                            
                        } else {
                            ForEach(hotelDB.hotels, id: \.id) { hotel in
                                NavigationLink(destination: HotelInfo(hotel: hotel)) {
                                    HStack {
                                        AsyncImage(url: URL(string: hotel.images.first ?? "")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 100, height: 100, alignment: .center)
                                        .padding(.trailing)
                                        
                                        
                                        VStack {
                                            Text(hotel.name)
                                                .font(.system(size: 28))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundColor(CustomColor.darkGreen)
                                            
                                            Text(hotel.location)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundColor(.gray)
                                        }
                                    }.background(Color(.systemBackground))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding([.bottom, .top], 6)
                                .padding([.leading, .trailing], 12)
                                .buttonStyle(.plain)

                                Divider().padding(0)
                            }
                        }
                        
                        
                        Button(action: {
                            self.addHotel = true
                        }, label: {
                            Text("+")
                                .font(.title3)
                                .padding(6)
                                .background(CustomColor.darkGreen)
                                .foregroundColor(Color(.white))
                                .clipShape(Circle())
                            
                            Text("Add Hotel")
                                .foregroundColor(CustomColor.darkGreen)
                        })
                        .padding([.bottom, .top], 6)
                        .padding([.leading, .trailing], 12)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                        
                    }.frame(maxWidth: .infinity)
                }.background(Color(.systemFill))
            }
        }
        .navigationTitle("Hotels")
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            trailing: Button(action: {
                self.userProfile = true
            }, label: {
                Image(systemName: "person.crop.circle")
                    .tint(CustomColor.darkGreen)
                    .background( NavigationLink("", destination: UserProfile()).opacity(0) )
            })
        )
        .navigationDestination(isPresented: $userProfile) {
            UserProfile()
        }
        .navigationDestination(isPresented: $addHotel) {
            AddHotel()
        }
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .onAppear() {
            hotelDB.fetchHotels()
        }
    }
}

struct ListHotels_Previews: PreviewProvider {
    static var previews: some View {
        ListHotels()
    }
}
