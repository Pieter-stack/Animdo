//
//  LottieScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI

struct LottieScreenView: View {
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
              LottieView(filename: "Loading")
                    .frame(width: getScreenBounds().width, height: getScreenBounds().width)
                    .padding(.leading, 40)
            }//Vstack
        }//ZStack
    }
}

struct LottieScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LottieScreenView()
    }
}
