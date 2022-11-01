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

    DashboardAnimals(animal: "Polar Bear", lifespan: "25-30 years", location: "Arctic Circle", Quantity: "31 000", image: "BearDash", coverImage: "BearCover", primaryColor: "CustomBlueLighter", secondaryColor: "CustomBlueLightest", description: "The largest bear in the world and the Arctic's top predator, polar bears are a powerful symbol of the strength and endurance of the Arctic.", iconColor: "White" ),
    DashboardAnimals(animal: "Elephant", lifespan: "60-70 years", location: "Africa", Quantity: "50 000", image: "ElephantDash", coverImage: "ElephantCover", primaryColor: "CustomBrownLight", secondaryColor: "CustomBrown", description: "Elephants are the largest existing land animals. Distinctive features of elephants include a long proboscis called a trunk, tusks, large ear flaps, pillar-like legs, and tough but sensitive skin.", iconColor: "Black"),
    DashboardAnimals(animal: "Shark", lifespan: "20-30 years", location: "Ocean", Quantity: "10% Left", image: "SharkDash", coverImage: "SharkCover", primaryColor: "CustomBlueLighter", secondaryColor: "CustomBlueLightest", description: "There are over 500 species of sharks. Like other fishes, sharks are cold-blooded, have fins, live in the water, and breathe with gills.", iconColor: "White"),
    DashboardAnimals(animal: "Sea Turtle", lifespan: "20-30 years", location: "Ocean", Quantity: "1 133 000 ", image: "TurtleDash", coverImage: "TurtleCover", primaryColor: "CustomeGreenLight", secondaryColor: "CustomGreenLighter", description: "Sea turtles, sometimes called marine turtles and are reptiles. The seven existing species of sea turtles are the flatback, green, hawksbill, leatherback, loggerhead, Kemp's ridley, and olive ridley sea turtles.", iconColor: "White"),
    DashboardAnimals(animal: "Lion", lifespan: "15-16 years", location: "Africa", Quantity: "20 000", image: "LionDash", coverImage: "LionCover", primaryColor: "CustomBrownLight", secondaryColor: "CustomBrown", description: "Unlike other cats, lions are very social animals. They live in groups, called prides, of around 30 lions. ", iconColor: "Black"),
    DashboardAnimals(animal: "Penguin", lifespan: "15-20 years", location: "Antarctica", Quantity: "2 200 000", image: "PenguinDash", coverImage: "PenguinCover", primaryColor: "CustomBlueLighter", secondaryColor: "CustomBlueLightest", description: "Penguins are flightless seabirds that live almost exclusively below the equator. Some island-dwellers can be found in warmer climates, but most penguins—reside in and around icy Antarctica.", iconColor: "White")
]
