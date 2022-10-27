//
//  TagAnimalViewModel.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import UIKit


class TagManager: ObservableObject{
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    private var storage = Storage.storage()
    @Published var message: String = ""
    
    func TagNewAnimal(tagCode: String, species: String, longitude: String, latitude: String, gender: String, age: Int, animalImage: UIImage, country: String, isoCode: String, ocean:String){
        
        let storageRef = storage.reference()
        let uid = UUID().uuidString
        let path = "animals/\(uid).jpg"
        let data = animalImage.jpegData(compressionQuality: 0.8)
        
        // Create a reference to the file you want to upload
        let ImageRef = storageRef.child(path)
        
        // Upload the file to the path
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        _ = ImageRef.putData(data!, metadata: metaData) { (metadata, error) in
            guard let metadata = metadata else {
                print(error?.localizedDescription ?? "errror")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            _ = metadata.size
            // You can also access to download URL after upload.
            ImageRef.downloadURL { (url, error) in
                guard url != nil else {
                    print(error?.localizedDescription ?? "errror")
                    return
                }
                print(url ?? "url")
                
                self.db.collection("animals").document(uid).setData([
                    "uid": uid,
                    "tagCode": tagCode,
                    "species":species,
                    "longitude": longitude,
                    "latitude": latitude,
                    "gender": gender,
                    "age": age,
                    "animalImage": url?.absoluteString as Any,
                    "country": country,
                    "isoCode": isoCode,
                    "ocean": ocean,
                    "adopted": false,
                    "adopter": ""
                ]){err in
                    if let err = err {
                        print("Error writing user to document:\(err)")
                    }else{
                        print("User added")
                    }
                }
            }
            if(error != nil){
                print(error.debugDescription)
                self.message = error?.localizedDescription ?? ""
            }
        }
    }

}

