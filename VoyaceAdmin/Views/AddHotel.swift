//
//  AddHotel.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-03-06.
//

import SwiftUI
import Combine

struct AddHotel: View {

    @State private var hotelName: String = ""
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var rooms: [Room] = [Room()]
    @State private var showPhotoPicker = false
    @State private var selectedImages = [UIImage]()
    
    let hotelDB = HotelsDB()
    
    @Environment(\.dismiss) private var dismiss

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
                
                Button(action: {
                    showPhotoPicker = true
                }, label: {
                    HStack {
                        Text("Upload images")
                    }
                })
                .fullScreenCover(isPresented: $showPhotoPicker) {
                    PhotoPicker(filter: .images, limit: 3) { results in
                        hotelDB.convertToUIImageArray(fromResults: results) { imagesOrNil, errorOrNil in
                            if let error = errorOrNil {
                                print(error)
                            }
                            if let images = imagesOrNil {
                                selectedImages = images
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                
                Section("Images") {
                    HStack {
                        ForEach(selectedImages, id:\.self) { img in
                            Image(uiImage: img)
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        }
                    }
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
                
                Button(action: {
                    rooms.append(Room())
                }, label: {
                    HStack {
                        Text("+")
                            .font(.title3)
                            .padding(6)
                            .background(Color(.systemBlue))
                            .foregroundColor(Color(.white))
                            .clipShape(Circle())
                        
                        Text("Add Room")
                    }
                })
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .padding(.bottom, 8)
                
                
                Button(action: {
                    // upload images to the server
                    var imageDataArr = [Data]()
                    for selectedImage in selectedImages {
                        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
                            imageDataArr.append(imageData)
                        }
                    }
                    
                    Task {
                        try await HotelsDB.uploadImages(imagesData: imageDataArr) { imagesLink in
                            HotelsDB().setHotel(hotel: Hotel(name: hotelName, description: description, location: location, images: imagesLink, rooms: rooms))
                        }
                    }
                    
                    dismiss()
                    
                    NotificationHandler.createNotification(title: "Hey", description: "New hotel info is saved!")
                }) {
                    Text("Save Info")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 40)
                        .padding([.bottom, .top], 6)
                        .padding([.leading, .trailing], 12)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    
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
