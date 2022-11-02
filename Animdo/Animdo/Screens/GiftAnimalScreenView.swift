//
//  GiftAnimalScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/02.
//

import SwiftUI
import AlertX

struct GiftAnimalScreenView: View {
    @ObservedObject private var vm = AllAnimalsViewModel()
    var animal : AllAnimals
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var email: String = ""
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                Text("Gift a Friend to a Friend")
                .foregroundColor(.black)
                .font(Font.custom("Aladin-regular", size: getScreenBounds().width/9))
                .underline()
                .padding(.bottom,getScreenBounds().width/100 )
                .padding(.top, 40)
                Spacer()
                ZStack{
                   RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.white))
                        .frame(width: getScreenBounds().width - 40)
                        .padding(.top, 100)
                    VStack{
                      
                        Image(animal.species == "Polar Bear" ? "BearDash" : animal.species == "Shark" ? "SharkDash" : animal.species == "Lion" ? "LionDash" : animal.species == "Elephant" ? "ElephantDash" : animal.species == "Sea Turtle" ? "TurtleDash" : "PenguinDash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        
                        Text("\(animal.name)")
                                .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/12))
                                .foregroundColor(.black)
                        Text("\(animal.species)")
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/25))
                                .foregroundColor(.black)
                                .padding(.top, -8)
                        HStack{
                            Image(systemName: "mappin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 6)
                            if animal.country == ""{
                                Text("\(animal.ocean)")
                                    .padding(.top, 2)
                                    .padding(.leading, -8)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                            }else{
                                Text("\(animal.country), \(animal.isoCode)")
                                    .padding(.top, 2)
                                    .padding(.leading, -8)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                            }
                        }//HStack
                        .padding(.horizontal, 30)
                        .padding(.top, 15)
                        Text("Enter your friend's email that you would like to send your adoptee to!")
                            .foregroundColor(.black)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/27))
                            .padding(.horizontal, 40)
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
                            .lineSpacing(1.2)
                        
                        if showAlert == true{
                            
                        }else{

                        VStack{
                            ZStack(alignment: .leading){
                                if email.isEmpty{
                                    Text("Friend's Email")
                                        .padding(.all, 20)
                                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                        .foregroundColor(.black).opacity(0.5)
                                        .padding(.bottom, -50)
                                }
                                TextField("", text: $email)
                                    .padding(.all, 20)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                    .foregroundColor(.black)
                                    .padding(.bottom, -50)
                            }//ZStack
                            
                            if email.isEmpty{
                                HStack{
                                    Text("")
                                        .padding(.all, 20)
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color("CustomBlueLight"))
                                        .frame(height: 5)
                                        .padding()
                                        .padding(.leading, -50)
                                }//HStack
                            }else{
                                HStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color("CustomBlueLight"))
                                        .frame(width: 30, height: 5)
                                        .padding(.leading)
                                    
                                    Text("Friend's Email")
                                        .padding(.all, 20)
                                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                        .foregroundColor(.black.opacity(0.5))
                                        .padding(.horizontal, -20)
                                    
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color("CustomBlueLight"))
                                        .frame(height: 5)
                                        .padding(.trailing)
                                }//HStack
                            }//Custom Input Line
                        }//VStack
                        .padding(.horizontal, 30)
                            
                        }
                        if showAlert == true{
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                ZStack{
                                   RoundedRectangle(cornerRadius: 90)
                                        .fill(Color("CustomBlue"))
                                        .frame(width: getScreenBounds().width - 180, height: 50)
                                    Text("Thank You!")
                                            .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/23))
                                            .foregroundColor(.white)
                                }//ZStack
                            })
                        }else{
                            Button(action: {
                                if email.isEmpty{
                                    
                                }else{
                                    vm.giftAnimal(animaluid: animal.uid, userEmail: email)
                                    showAlert = true
                                }
                                
                                
                             
                            }, label: {
                                ZStack{
                                   RoundedRectangle(cornerRadius: 90)
                                        .fill(Color("CustomBlueLight"))
                                        .frame(width: getScreenBounds().width - 120, height: 60)
                                    Text("Gift Me!")
                                            .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/19))
                                            .foregroundColor(.white)
                                }//ZStack
                            })
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                ZStack{
                                   RoundedRectangle(cornerRadius: 90)
                                        .fill(Color("CustomBlue"))
                                        .frame(width: getScreenBounds().width - 180, height: 50)
                                    Text("Keep Me!")
                                            .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/23))
                                            .foregroundColor(.white)
                                }//ZStack
                            })
                        }
                        
                        
                    }//VStack
                    .padding(.bottom, 10)
                }//ZStack
                
            }//VStack
        }//ZStack
    }
}

struct GiftAnimalScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GiftAnimalScreenView(animal: AllAnimals(uid: "1", name: "Alex", tagCode: "123456", species: "Polar Bear", longitude: "1.10", latitude: "2.20", gender: "Male", age: 10, animalImage: "https://firebasestorage.googleapis.com:443/v0/b/animdo.appspot.com/o/animals%2FD5D5A4D1-1238-432D-ACA0-B22A32386FAB.jpg?alt=media&token=c8cf4ff6-ab58-413a-92a0-2363c919ac73", country: "South Africa", isoCode: "ZA", ocean: "atlantic", adopted: true, adoper: "1111", tokens: "1"))
    }
}
