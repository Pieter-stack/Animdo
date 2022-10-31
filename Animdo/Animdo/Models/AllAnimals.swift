//
//  AllAnimals.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/24.
//

import Foundation


struct AllAnimals: Identifiable{
    var id: String = UUID().uuidString
    var uid: String
    var tagCode: String
    var species: String
    var longitude: String
    var latitude: String
    var gender: String
    var age: Int
    var animalImage: String
    var country: String
    var isoCode: String
    var ocean: String
    var adopted: Bool
    var adoper: String
    var tokens: String
}

