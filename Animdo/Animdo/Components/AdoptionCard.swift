//
//  AdoptionCard.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/31.
//

import SwiftUI
import SDWebImageSwiftUI

struct AdoptionCard: View {
    var image: String
    var species: String
    var age: Int
    var country: String
    var ocean: String
    var isoCode: String
    var tokens: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(height: 330)
            VStack{
                WebImage(url:URL(string: image))
                    .resizable()
                    .frame(width: 180, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.top, 10)
    
                Text(species)
                    .padding(.bottom, -12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 30)
                    .padding(.leading, 20)
                    .padding(.trailing, 15)
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                        .foregroundColor(.black)
                
                Text("\(age) years old")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .padding(.bottom, -8)
                .padding(.leading, 23)
                .padding(.trailing, 15)
                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/25))
                    .foregroundColor(.black)
                HStack{
                   Image(systemName: "mappin")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 13)
                        .padding(.leading, 20)
                        .foregroundColor(.black)
                    if country == ""{
                        Text("\(ocean)")
                            .padding(.top, 2)
                            .padding(.leading, -8)
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/35))
                            .foregroundColor(.black)
                    }else{
                        Text("\(country), \(isoCode)")
                            .padding(.top, 2)
                            .padding(.leading, -8)
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/35))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }//Hstack
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("CustomBlueLight"))
                    .frame(height: 2)
                    .padding(.horizontal)
                Spacer()
                
                HStack{
                    Text("\(tokens)")
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                        .foregroundColor(.black)
                        .padding(.leading)
                    Spacer()
                    ZStack{
                        Rectangle()
                            .frame(width: 45, height: 35)
                            .foregroundColor(Color("CustomBlueLight"))
                            .padding(.bottom, 15)
                            .padding(.trailing, 15)
                            .cornerRadius(15)
                            .padding(.bottom, -15)
                            .padding(.trailing, -15)
                            .padding(.top, 15)
                            .padding(.leading, 15)
                            .cornerRadius(15)
                            .padding(.top, -15)
                            .padding(.leading, -15)
                            .padding(.trailing)
                        Image("LionCoin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23)
                            .padding(.trailing)
                        
                    }//ZStack
                }//HStack
                    .padding(.top, -40)
    
            }//VStack
        }//ZStack
    }
}

struct AdoptionCard_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionCard(image: "", species: "", age: 0, country: "", ocean: "", isoCode: "", tokens: "")
    }
}
