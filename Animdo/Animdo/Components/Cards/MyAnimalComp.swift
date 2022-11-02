//
//  MyAnimalComp.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/31.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyAnimalComp: View {
    var image: String
    var name:String
    var species : String
    var country: String
    var ocean: String
    var isoCode: String
    var color: String
    var colorSecondary: String
    var body: some View {
        ZStack{
            WebImage(url:URL(string: image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getScreenBounds().width / 1.1, height: getScreenBounds().width / 1.1)
                .clipShape(
                    Circle()
                )
                .padding(.trailing, -100)
            ZStack{
                Circle()
                    .fill(Color(color))
                    .frame(width: getScreenBounds().width / 3)
                VStack{
                    Text(name)
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                        .foregroundColor(Color("Black"))
                        .padding(.top, 20)
                    Text(species)
                        .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/30))
                        .foregroundColor(Color("Black"))
                    HStack{
                           Image(systemName: "mappin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 13)
                                .foregroundColor(.black)
                            if country == ""{
                                Text("\(ocean)")
                                    .padding(.leading, -8)
                                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/35))
                                    .foregroundColor(.black)
                            }else{
                                Text("\(country), \(isoCode)")
                                    .padding(.leading, -8)
                                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/35))
                                    .foregroundColor(.black)
                            }
                        
                        }//Hstack
                    .frame(width: 130)
                    ZStack{
                        Circle()
                            .fill(Color(colorSecondary))
                            .frame(width:50)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .font(.title3)
                        
                    }
                    .offset(x: 50, y: 7)
                }//VStack
                .padding(.bottom, -15)
            }//ZStack
            .offset(x: -70, y: 150)


        }//ZStack
    }
}

struct MyAnimalComp_Previews: PreviewProvider {
    static var previews: some View {
        MyAnimalComp(image: "https://firebasestorage.googleapis.com:443/v0/b/animdo.appspot.com/o/animals%2FD5D5A4D1-1238-432D-ACA0-B22A32386FAB.jpg?alt=media&token=c8cf4ff6-ab58-413a-92a0-2363c919ac73",name: "Alex" ,species: "Polar bear",country: "South Africa",ocean: "",isoCode: "ZA", color: "CustomBlueLighter", colorSecondary: "CustomBlue")
    }
}
