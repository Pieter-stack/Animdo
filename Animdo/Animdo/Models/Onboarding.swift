//
//  Onboarding.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/08.
//

import SwiftUI

//Onboarding Model and Screens

struct Onboarding: Identifiable{
    var id = UUID().uuidString
    var title: String
    var description: String
    var picture: String
    var background: String
    var offset: CGSize = .zero
    
}



