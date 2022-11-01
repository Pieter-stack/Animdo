//
//  CustomPin.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI

struct CustomPin: View {
    var color: String
    var image: String
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color(color))
                    .frame(width: 40)
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }//ZStack
            Image(systemName: "triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15)
                .foregroundColor(Color(color))
                .rotationEffect(Angle(degrees: 180))
                .offset(y:-12)
            
        }//VStack
    }
}

struct CustomPin_Previews: PreviewProvider {
    static var previews: some View {
        CustomPin(color: "CustomBlueLight", image: "PolarBearIcon")
    }
}
