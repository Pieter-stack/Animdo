//
//  Title.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI

struct Title: View {
    var Titleblack: String
    var Titlebrown: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(Titleblack)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                    .foregroundColor(Color("CustomBeige"))
                Text(Titlebrown)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                    .foregroundColor(.black)
            }//HStack
        }//VStack
        .frame(width: getScreenBounds().width, alignment: .leading)
        .padding(.leading)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(Titleblack: "", Titlebrown: "")
    }
}
