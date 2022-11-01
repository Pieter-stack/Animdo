//
//  FilterBtnMyAnimals.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/31.
//

import SwiftUI

struct FilterBtnMyAnimals: View {
    var image: String
    var color: String
    var size: CGFloat
    var sizeIcon: CGFloat
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(color))
                .frame(width: size)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeIcon)
        }//ZStack
    }
}

struct FilterBtnMyAnimals_Previews: PreviewProvider {
    static var previews: some View {
        FilterBtnMyAnimals(image: "LionIcon", color: "CustomBrown", size: 60, sizeIcon: 30)
    }
}
