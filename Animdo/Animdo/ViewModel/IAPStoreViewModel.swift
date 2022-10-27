//
//  IAPStore.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/27.
//

import StoreKit

final class IAPStore: ObservableObject {
    @Published private(set) var tokens: TokenA
    @Published private(set) var tokens2: TokenB
    @Published private(set) var tokens3: TokenC
  init() async throws {
    tokens = try await .init()
    tokens2 = try await .init()
    tokens3 = try await .init()
    task = Task.detached { [unowned self] in
      for await result in Transaction.updates {
        try? await processTransaction(result: result)
      }
    }
  }

  deinit {
    task.cancel()
  }

  private var task: Task<Void, Never>!
}

// MARK: - internal
extension IAPStore {
  func buy<Purchasable: Animdo.Purchasable>(_ purchasable: Purchasable) async throws {
    if case .success(let result) = try await purchasable.product.purchase() {
      try await processTransaction(result: result)
    }
  }

  func buyTokens() {
      tokens.ConsumableCount -= 1
  }
}

// MARK: - private
@MainActor private extension IAPStore {
  func processTransaction(result: VerificationResult<Transaction>) throws {
    let transaction = try result.payloadValue
      print(transaction.productID)

      switch transaction.productID{
      case "com.openwindow.Animdo.1adoption":
          tokens.ConsumableCount += 1
      case "com.openwindow.Animdo.5adoption":
           tokens.ConsumableCount += 5
      case "com.openwindow.Animdo.10adoption":
           tokens.ConsumableCount += 10
      default:
          fatalError()
      }
        

    Task { await transaction.finish() }
  }
}
