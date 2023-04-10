//
//  AddHotel.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-03-06.
//

import SwiftUI

struct RoomInfo: Identifiable, Hashable {
    var id: UUID
    var roomName: String
    var roomFare: String
    
    init() {
        self.roomName = ""
        self.roomFare = ""
        self.id = UUID()
    }
    
    init(roomName: String, roomFare: String) {
        self.roomName = roomName
        self.roomFare = roomFare
        self.id = UUID()
    }
}


struct AddHotel: View {

    @State private var hotelName: String = ""
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var rooms: [RoomInfo] = [RoomInfo()]

    var body: some View {
        NavigationView {
            Form {
                Section("Hotel Name") {
                    TextField(
                        "Hotel Name",
                        text: $hotelName
                    )
                }
                
                Section("Location") {
                    TextField(
                        "Barrie",
                        text: $location
                    )
                }
                
                Section("Description") {
                    TextEditor(
                        text: $description
                    )
                    .frame(maxHeight: 80)
                }
                
                Section("Images") {
                    Text("Upload images")
                }
                
                Text("List of Rooms")
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    .padding(0)
                
                ForEach($rooms, id: \.id) { room in
                    Section("Room Info") {
                        TextField("Room Name", text: room.roomName)

                        TextField("Fare", text: room.roomFare)
                            .keyboardType(.numberPad)
                    }.padding(.top, 0)
                }
                
                Button("Add Room", action: {
                    rooms.append(RoomInfo())
                })
                
                Spacer().listRowBackground(Color(UIColor.systemGroupedBackground))
                
                
                Button(action: {
                    print(rooms)
                    NotificationHandler.createNotification(title: "Hey", description: "New hotel info is saved!")
                }) {
                    Text("Save Info")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.orange)
                        .cornerRadius(15.0)
                }.listRowBackground(Color(UIColor.systemGroupedBackground))
            }
        }.navigationTitle("Add Hotel Info")
    }
}

struct AddHotel_Previews: PreviewProvider {
    static var previews: some View {
        AddHotel()
    }
}
