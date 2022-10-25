//
//  DashboardAnimals.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/25.
//

import Foundation
import SwiftUI


struct DashboardAnimals: Identifiable{
    var id = UUID()
    var animal: String
    var lifespan: String
    var location: String
    var Quantity: String
    var image: String
    var coverImage: String
    var primaryColor: String
    var secondaryColor: String
    var description: String
    var iconColor: String
}

var dashAnimals = [

    DashboardAnimals(animal: "Polar Bear", lifespan: "25-30 years", location: "Arctic Circle", Quantity: "31 000", image: "BearDash", coverImage: "BearCover", primaryColor: "CustomBlueLighter", secondaryColor: "CustomBlueLightest", description: "Polar bear description", iconColor: "White" ),
    DashboardAnimals(animal: "Elephant", lifespan: "60-70 years", location: "Africa", Quantity: "50 000", image: "ElephantDash", coverImage: "ElephantCover", primaryColor: "CustomBrownLight", secondaryColor: "CustomBrown", description: "Elephant description", iconColor: "Black"),
    DashboardAnimals(animal: "Shark", lifespan: "20-30 years", location: "Ocean", Quantity: "10% Left", image: "SharkDash", coverImage: "SharkCover", primaryColor: "CustomBlueLighter", secondaryColor: "CustomBlueLightest", description: "Shark description", iconColor: "White"),
    DashboardAnimals(animal: "Sea Turtle", lifespan: "20-30 years", location: "Ocean", Quantity: "1 133 000 ", image: "TurtleDash", coverImage: "TurtleCover", primaryColor: "CustomeGreenLight", secondaryColor: "CustomGreenLighter", description: "Turtle description", iconColor: "White"),
    DashboardAnimals(animal: "Lion", lifespan: "15-16 years", location: "Africa", Quantity: "20 000", image: "LionDash", coverImage: "LionCover", primaryColor: "CustomBrownLight", secondaryColor: "CustomBrown", description: "Lion description", iconColor: "Black"),
    DashboardAnimals(animal: "Penguin", lifespan: "15-20 years", location: "Antarctica", Quantity: "2 200 000", image: "PenguinDash", coverImage: "PenguinCover", primaryColor: "CustomBlueLighter", secondaryColor: "CustomBlueLightest", description: "Penguin description", iconColor: "White")
]
