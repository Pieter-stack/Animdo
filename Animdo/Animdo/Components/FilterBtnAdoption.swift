//
//  FilterBtnAdoption.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/31.
//

import SwiftUI

struct FilterBtnAdoption: View {
    var image: String
    var color: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(color))
                .frame(width: 60, height: 40)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
        }//ZStack
    }
}

struct FilterBtnAdoption_Previews: PreviewProvider {
    static var previews: some View {
        FilterBtnAdoption(image: "LionIcon", color: "CustomBrown")
    }
}
