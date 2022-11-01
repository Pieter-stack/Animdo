//
//  Purchasable.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/27.
//

import Foundation
import StoreKit

protocol Purchasable: Identifiable{
    var product: Product { get }
}


extension StoreKit.Product.ID{
    static var prefix: Self { "com.openwindow.Animdo." }
}

//Mark: Identifiable
extension Purchasable{
    var id: String { product.id }
}
