//
//  AdoptionScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI
import SDWebImageSwiftUI
struct AdoptionScreenView: View {
    @ObservedObject private var vm = AllAnimalsViewModel()
    var vGridLayout: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 200),spacing: 10)]
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                VStack(alignment: .leading){
                    HStack{
                    Text("Adopt")
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                        .foregroundColor(Color("CustomBeige"))
                    Text("A Friend")
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                        .foregroundColor(.black)
                        Spacer()
                }//HStack
                    .padding(.leading, 30)
                    
                    ScrollView{
                        LazyVGrid(columns: vGridLayout){
                            ForEach(vm.animals){animal in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .frame(height: 280)
                                    VStack{
                                        WebImage(url:URL(string: animal.animalImage))
                                            .resizable()
                                            .frame(width: 180, height: 180)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .padding(.top, 10)
                            
                                        Text(animal.species)
                                            .padding(.bottom, -12)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(height: 30)
                                            .padding(.leading, 15)
                                            .padding(.trailing, 15)
                                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                                                .foregroundColor(.black)
                                        
                                        Text("\(animal.age) years old")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 5)
                                        .padding(.bottom, -8)
                                        .padding(.leading, 15)
                                        .padding(.trailing, 15)
                                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/25))
                                            .foregroundColor(.black)
                                        HStack{
                                           Image(systemName: "mappin")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 15, height: 13)
                                                .padding(.leading, 10)
                                            if animal.country == ""{
                                                Text("\(animal.ocean)")
                                                    .padding(.top, 2)
                                                    .padding(.leading, -8)
                                                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/35))
                                                    .foregroundColor(.black)
                                            }else{
                                                Text("\(animal.country),\(animal.isoCode)")
                                                    .padding(.top, 2)
                                                    .padding(.leading, -8)
                                                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/35))
                                                    .foregroundColor(.black)
                                            }
                                            Spacer()
                                        }//Hstack
                                        
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Rectangle()
                                                .frame(width: 50, height: 40)
                                                .foregroundColor(Color("CustomBlueLight"))
                                                .padding(.bottom, 20)
                                                .padding(.trailing, 20)
                                                .cornerRadius(20)
                                                .padding(.bottom, -20)
                                                .padding(.trailing, -20)
                                                .padding(.top, 20)
                                                .padding(.leading, 20)
                                                .cornerRadius(20)
                                                .padding(.top, -20)
                                                .padding(.leading, -20)
                                        }//hstack
                                        .padding(.top, -40)
                                    }//VStack
                                }//ZStack
                                
                            }//foreach
                        }//lazyvgrid
                    }//scrollview
                    

                    Spacer()
                }//VStack
            }//Vstack
        }//ZStack
        .onAppear(){
            self.vm.fetchAllAnimals()
        }
    }
}

struct AdoptionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionScreenView()
    }
}



