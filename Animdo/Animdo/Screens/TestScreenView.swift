//
//  TestScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/27.
//

import SwiftUI
import StoreKit

struct TestScreenView: View {
    @State private var store: IAPStore?
    var body: some View {
        if let store = store {
          PurchaseScreenView()
            .environmentObject(store)
        } else {
           SettingsScreenView()
                .task {
                    store = try? await .init()
                }
        }
    }
}

struct TestScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TestScreenView()
    }
}
