//
//  AdoptionScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI

struct AdoptionScreenView: View {
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            Text("Adoption View")
        }//ZStack
    }
}

struct AdoptionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionScreenView()
    }
}
