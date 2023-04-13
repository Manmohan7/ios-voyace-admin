//
//  HotelsDB.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-10.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import PhotosUI


struct Hotel: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var description: String
    var location: String
    var rooms: [Room]?
    var images = [String]()

    init(name: String, description: String, location: String, images: [String], rooms: [Room]) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.location = location
        self.images = images
        self.rooms = rooms
    }

    init(id: String, name: String, description: String, location: String, images: [String], rooms: [Room]) {
        self.id = id
        self.name = name
        self.description = description
        self.location = location
        self.images = images
        self.rooms = rooms
    }
}

struct Room: Identifiable, Hashable, Codable {
    var id: UUID
    var roomName: String
    var roomFare: String
    
    init() {
        self.id = UUID()
        self.roomName = ""
        self.roomFare = ""
    }
    
    init(roomName: String, roomFare: String) {
        self.id = UUID()
        self.roomName = roomName
        self.roomFare = roomFare
    }
    
    init(id: UUID, roomName: String, roomFare: String) {
        self.id = id
        self.roomName = roomName
        self.roomFare = roomFare
    }
}

class HotelsDB: ObservableObject {
    
    @Published var hotels: [Hotel] = []
        
    let uid = UserDefaults.standard.string(forKey: "uid") ?? ""
    
    private lazy var databasePath = Firestore.firestore().collection("users").document(uid).collection("hotels")
    
    func setHotel(hotel: Hotel) {
        do {
            try databasePath.document().setData(from: hotel)
            
            // refresh list view
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.fetchHotels()
            }
        } catch {
            print("some issue in set data")
        }
    }
    
    func fetchHotels() {
        databasePath.getDocuments { snapshot, error in
            guard error == nil else { return }
            
            var hotels = [Hotel]()
            
            if let documents = snapshot?.documents {
                for doc in documents {
                    do {
                        let hotel = try doc.data(as: Hotel.self)
                        hotels.append(hotel)
                    } catch {
                        print("error in fetching hotel info")
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.hotels = hotels
            }
        }
    }
    
    func convertToUIImageArray(fromResults results: [PHPickerResult], onComplete: @escaping ([UIImage]?, Error?) -> Void) {
        // Will be used to store the images that get created from results.
        var images = [UIImage]()

        let dispatchGroup = DispatchGroup()
        for result in results {
            dispatchGroup.enter()
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (imageOrNil, errorOrNil) in
                    if let error = errorOrNil {
                        onComplete(nil, error)
                    }
                    if let image = imageOrNil as? UIImage {
                        images.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            onComplete(images, nil)
        }
    }
    
    static func uploadImages(imagesData: [Data], completion: ([String]) -> ()) async throws {
        var imageLinks = [String]()
        
        for imageData in imagesData {
            try await uploadImage(imageData: imageData) { imgLink in
                imageLinks.append(imgLink)
                if imageLinks.count == imagesData.count {
                    completion(imageLinks)
                }
            }
        }
        
    }
    
    static func uploadImage(imageData: Data, completion: (String) -> ()) async throws {
        let storage = Storage.storage().reference()
        let uid = Auth.auth().currentUser?.uid ?? ""
        let childUID = uid + UUID().uuidString
        let ref = storage
            .child("hotelImages")
            .child(childUID)
        
        do {
            _ = try await ref.putDataAsync(imageData, metadata: nil)
            let url = try await ref.downloadURL()
            completion(url.absoluteString)
        } catch {
            print("[Error] uploadImage:", error)
            throw error
        }
    }
}
