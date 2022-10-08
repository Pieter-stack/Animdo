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

//Onbaording screen data

var boardingScreens: [Onboarding] = [
Onboarding(title: "Location Tracking", description: "To protect the animals, Animdo will not share live locations for their safety. Only YOU will be able to know exactly where your animal was tagged for the first time.", picture: "OnboardingImgOne", background: "OnboardingBGOne"),
Onboarding(title: "Adopt a wild Animal", description: "By adopting one of these animals: Elephant, Lion, Polar Bear, Penguin, Shark, Sea Turtle you help save them. All of the funds goes to non profit organizations.", picture: "OnboardingImgTwo", background: "OnboardingBGTwo"),
Onboarding(title: "Name your animal", description: "When adopting an animal to be rescued you will then have access to give them a name and also see more details about your animal, you will also be able to donate more to help your little friend out!", picture: "OnboardingImgThree", background: "OnboardingBGThree")
]

//model: Intro -> Onboarding
//Home -> onboardingScreenView
//Home:intros -> boardingScreens
//Home: IntroView -> OnboardingView
//Home: intro-> onboard
