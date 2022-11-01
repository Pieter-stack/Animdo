//
//  PurchasefailScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/27.
//

import SwiftUI
import StoreKit

struct PurchasefailScreenView: View {
    @State private var store: IAPStore?
    var body: some View {
        if let store = store {
          PurchaseScreenView()
            .environmentObject(store)
        } else {
           SettingsScreenView() // replace with content
                .task {
                    store = try? await .init()
                }
        }
    }
}

struct PurchasefailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasefailScreenView()
    }
}
