//
//  MyAnimalsPurchaseFail.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/31.
//

import SwiftUI

struct MyAnimalsPurchaseFail: View {
    @State private var store: IAPStore?
    @ObservedObject private var vm = AllAnimalsViewModel()
    var animal : AllAnimals
    var body: some View {
        if let store = store {
          MyAnimalsDetailScreenView(animal: animal)
            .environmentObject(store)
        } else {
           SettingsScreenView() // replace with content
                .task {
                    store = try? await .init()
                }
        }
    }
}

struct MyAnimalsPurchaseFail_Previews: PreviewProvider {
    static var previews: some View {
        MyAnimalsPurchaseFail(animal: AllAnimals(uid: "1", name: "", tagCode: "123456", species: "Shark", longitude: "1.10", latitude: "2.20", gender: "Male", age: 10, animalImage: "https://firebasestorage.googleapis.com:443/v0/b/animdo.appspot.com/o/animals%2FD5D5A4D1-1238-432D-ACA0-B22A32386FAB.jpg?alt=media&token=c8cf4ff6-ab58-413a-92a0-2363c919ac73", country: "South Africa", isoCode: "ZA", ocean: "atlantic", adopted: true, adoper: "1111", tokens: "1"))
    }
}
