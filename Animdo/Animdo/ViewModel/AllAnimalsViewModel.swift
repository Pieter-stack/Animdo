//
//  AllAnimalsViewModel.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/24.
//

import Foundation
import FirebaseFirestore
import Firebase

class AllAnimalsViewModel: ObservableObject{
    @Published var animals = [AllAnimals]()
    private var db = Firestore.firestore()
    
    func fetchAllAnimals(){
        db.collection("animals").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            
            self.animals = documents.map{ (queryDocumentSnapshot) -> AllAnimals in
                let data = queryDocumentSnapshot.data()
                let uid = data["uid"] as? String ?? ""
                let tagCode = data["tagCode"] as? String ?? ""
                let species = data["species"] as? String ?? ""
                let longitude = data["longitude"] as? String ?? ""
                let latitude = data["latitude"] as? String ?? ""
                let gender = data["gender"] as? String ?? ""
                let age = data["age"] as? Int ?? 0
                let animalImage = data["animalImage"] as? String ?? ""
                let country = data["country"] as? String ?? ""
                let isoCode = data["isoCode"] as? String ?? ""
                let ocean = data["ocean"] as? String ?? ""
                let adopted = data["adopted"] as? Bool ?? false
                return AllAnimals(uid: uid, tagCode: tagCode, species: species, longitude: longitude, latitude: latitude, gender: gender, age: age, animalImage: animalImage, country: country, isoCode: isoCode, ocean: ocean, adopted: adopted)
                
            }
        }
    }
    
}
