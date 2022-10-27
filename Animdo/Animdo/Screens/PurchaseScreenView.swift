//
//  PurchaseScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/27.
//

import SwiftUI
import StoreKit

struct PurchaseScreenView: View {
    @EnvironmentObject private var store: IAPStore
    var body: some View {
        TokenA.Row()
        TokenB.Row()
//        TokenC.Row()
    }
}

struct PurchaseScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseScreenView()
    }
}


private extension TokenA {
  struct Row: View {
    @EnvironmentObject private var store: IAPStore
    @State private var alertIsPresented = false

    var body: some View {
      ProductRow(product: store.tokens.product) {
        let consumableCount = store.tokens.ConsumableCount
          Image(systemName: "\(consumableCount).circle")
            .font(.system(.largeTitle))

          PurchaseButton(purchasable: store.tokens)
        
      }
      .alert(
        "Unlock Random Owl?",
        isPresented: $alertIsPresented,
        actions: {
          Button("Yes", action: store.buyTokens)
          Button("No", role: .cancel) { }
        },
        message: {
          Text("Do you wish to unlock a random owl?")
        }
      )
    }
  }
}

private extension TokenB {
  struct Row: View {
    @EnvironmentObject private var store: IAPStore
    @State private var alertIsPresented = false

    var body: some View {
      ProductRow(product: store.tokens2.product) {
        let consumableCount = store.tokens2.ConsumableCount
          Image(systemName: "\(consumableCount).circle")
            .font(.system(.largeTitle))

          PurchaseButton(purchasable: store.tokens2)
        
      }
      .alert(
        "Unlock Random Owl?",
        isPresented: $alertIsPresented,
        actions: {
          Button("Yes", action: store.buyTokens)
          Button("No", role: .cancel) { }
        },
        message: {
          Text("Do you wish to unlock a random owl?")
        }
      )
    }
  }
}
//
//private extension TokenC {
//  struct Row: View {
//    @EnvironmentObject private var store: IAPStore
//    @State private var alertIsPresented = false
//
//    var body: some View {
//      ProductRow(product: store.tokens3.product) {
//        let consumableCount = store.tokens3.ConsumableCount
//        if consumableCount > 0 {
//          Button {
//            alertIsPresented = true
//          } label: {
//            Image(systemName: "\(consumableCount).circle")
//              .font(.system(.largeTitle))
//          }
//        } else {
//          PurchaseButton(purchasable: store.tokens3)
//        }
//      }
//      .alert(
//        "Unlock Random Owl?",
//        isPresented: $alertIsPresented,
//        actions: {
//          Button("Yes", action: store.buyTokens)
//          Button("No", role: .cancel) { }
//        },
//        message: {
//          Text("Do you wish to unlock a random owl?")
//        }
//      )
//    }
//  }
//}



private struct ProductRow<TrailingView: View>: View {
  let product: Product
  @ViewBuilder let trailingView: () -> TrailingView

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: nil) {
        Text("\(product.displayName) - \(product.displayPrice)")
        Text(product.description)
      }
      Spacer()
      trailingView()
    }
    .padding()
  }
}

private struct PurchaseButton<Purchasable: Animdo.Purchasable>: View {
  let purchasable: Purchasable
  @EnvironmentObject private var store: IAPStore

  var body: some View {
    Button {
      Task {
        try await store.buy(purchasable)
      }
    } label: {
      HStack {
        Image(systemName: "cart")
        Text("Buy")
      }
    }
    .buttonStyle(.plain)
    .padding(10)
    .foregroundColor(.yellow)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .stroke(Color.yellow, lineWidth: 2)
    )
  }
}
