//
//  OnRegister.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/09.
//

import SwiftUI

struct OnRegister: Identifiable{
    var id = UUID().uuidString
    var background: String
    var image: String
    var title: String
}


var boardingReg: [OnRegister] = [
   OnRegister(background: "RegisterBGOne", image: "RegisterImgOne", title: "Register"),
   OnRegister(background: "RegisterBGTwo", image: "RegisterImgTwo", title: "Register")
]
