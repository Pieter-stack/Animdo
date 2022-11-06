//
//  AdoptionPurchaseFailScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI

struct AdoptionPurchaseFailScreenView: View {
    @State private var store: IAPStore?
    var body: some View {
        if let store = store {
          AdoptionScreenView()
            .environmentObject(store)
        } else {
          LottieView(filename: "Loading")
                .task {
                    store = try? await .init()
                }
        }
        
    }
}

struct AdoptionPurchaseFailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionPurchaseFailScreenView()
    }
}
