//
//  AdoptionDetailPurchaseScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/06.
//

import SwiftUI

struct AdoptionDetailPurchaseScreenView: View {
    @ObservedObject private var vm = AllAnimalsViewModel()
    var animal : DashboardAnimals = dashAnimals[0]
    @State private var store: IAPStore?
    @Binding var filterSearch: String
    var body: some View {
        if let store = store {
        AdoptionDashScreenView(filterSearch: .constant(filterSearch))
            .environmentObject(store)
        } else {
          LottieView(filename: "Loading")
                .task {
                    store = try? await .init()
                }
        }
    }
}

struct AdoptionDetailPurchaseScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionDetailPurchaseScreenView(animal: dashAnimals[0], filterSearch: .constant("ALL"))
    }
}
