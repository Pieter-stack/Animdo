//
//  TokenA.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/27.
//

import Foundation
import StoreKit
import SwiftKeychainWrapper



struct TokenA: Purchasable{
    let product: Product
    let productIdentifiers = [ .prefix + "1adoption"]

    
    init() async throws{
        product = try await Product.products(
            for: productIdentifiers
        ).first!
    }
    var ConsumableCount: Int{
        get { KeychainWrapper.standard.integer(forKey: id) ?? 0}
        set { KeychainWrapper.standard.set(newValue, forKey: id)}
    }
}

struct TokenB: Purchasable{
    let product: Product
    let productIdentifiers = [.prefix + "5adoption"]

    
    init() async throws{
        product = try await Product.products(
            for: productIdentifiers
        ).first!
    }
    var ConsumableCount: Int{
        get { KeychainWrapper.standard.integer(forKey: id) ?? 0}
        set { KeychainWrapper.standard.set(newValue, forKey: id)}
    }
}

struct TokenC: Purchasable{
    let product: Product
    let productIdentifiers = [.prefix + "10adoption"]

    
    init() async throws{
        product = try await Product.products(
            for: productIdentifiers
        ).first!
    }
    var ConsumableCount: Int{
        get { KeychainWrapper.standard.integer(forKey: id) ?? 0}
        set { KeychainWrapper.standard.set(newValue, forKey: id)}
    }
}

private extension Sequence where Element: Sendable {
  func map<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws -> Transformed
  ) async rethrows -> [Transformed] {
    try await withThrowingTaskGroup(
      of: EnumeratedSequence<[Transformed]>.Element.self
    ) { group in
      for (offset, element) in enumerated() {
        group.addTask(priority: priority) {
          (offset, try await transform(element))
        }
      }

      return try await group.reduce(
        into: map { _ in nil } as [Transformed?]
      ) {
        $0[$1.offset] = $1.element
      } as! [Transformed]
    }
  }
}


