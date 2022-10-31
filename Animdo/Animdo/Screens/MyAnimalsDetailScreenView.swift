//
//  MyAnimalsDetailScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/31.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyAnimalsDetailScreenView: View {
    @ObservedObject private var vm = AllAnimalsViewModel()
    var device = UIDevice.current.name
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var store: IAPStore
    var animal : AllAnimals
    @State private var showAlert = false
    @State private var AlertValue = ""
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.black)
                    })
                    .padding(.top, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 0 : 50)
                    .padding(.leading, 20)
                    Spacer()
                    NavigationLink(destination: PurchasefailScreenView().navigationBarBackButtonHidden(true)){
                        ZStack{
                            Image("TopCoin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120)
                            HStack{
                                Image("LionCoin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .padding(.top, -5)
//                                let consumableCount = store.tokens.ConsumableCount
//                                Text("\(consumableCount)")
//                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
//                                    .foregroundColor(Color("White"))
                            }//HStack
                            .padding(.top, -10)
                        }//ZStack
                    }//Nav link
                }//HStack
                .ignoresSafeArea()
                HStack{
                        Text("How is,")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/13))
                            .foregroundColor(Color("CustomBeige"))
                        Text("Alex?")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/12))
                            .foregroundColor(.black)
                    Spacer()
                }//HStack
                .padding(.leading, 30)
                .padding(.top, -70)
                ZStack{
                    WebImage(url:URL(string: animal.animalImage))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getScreenBounds().width - 50, height: getScreenBounds().height/4.5)
                        .cornerRadius(12)
                        .blur(radius: 5)
                        .opacity(0.5)
                    WebImage(url:URL(string: animal.animalImage))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10.0)
                        .frame(width: getScreenBounds().width - 50, height: getScreenBounds().height/4.5)
                        .opacity(0.9)
                }.padding(.top, -10)
                
                HStack(spacing: 10){
                    VStack{
                     Text("Species")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/25))
                            .foregroundColor(.black)

                        Text(animal.species)
                            .padding(.top, 5)
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/29))
                            .foregroundColor(.black)
                    }//VStack
                    .frame(width: getScreenBounds().width/5)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color("Black"))
                        .frame(width: 2, height: 70)
                    
                    VStack{
                        Text("Tag Code")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/25))
                            .foregroundColor(.black)
                        Text(animal.tagCode)
                            .padding(.top, 5)
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/29))
                            .foregroundColor(.black)
                    }//VStack
                    .frame(width: getScreenBounds().width/5)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color("Black"))
                        .frame(width: 2, height: 70)
                    VStack{
                        Text("Age")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/25))
                            .foregroundColor(.black)
                            
                        Text("\(animal.age)")
                            .padding(.top, 5)
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/29))
                            .foregroundColor(.black)
                    }//VStack
                    .frame(width: getScreenBounds().width/5)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color("Black"))
                        .frame(width: 2, height: 70)
                        .background()
                    VStack{
                        Text("Gender")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/25))
                            .foregroundColor(.black)
                      
                        Text(animal.gender)
                            .padding(.top, 5)
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/29))
                            .foregroundColor(.black)
                    }//VStack
                    .frame(width: getScreenBounds().width/5)
                }//HStack
                .padding(.top, 30)
                .padding(.horizontal)
                HStack{
                        Text("See My Home")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                            .foregroundColor(Color("CustomBeige"))
                    Spacer()
                }//HStack
                .padding(.leading, 30)
                .padding(.top, 30)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("My Needs")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                            .foregroundColor(Color("CustomBeige"))
                        Text("Help by donating tokens for animals welfare!")
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/25))
                            .foregroundColor(Color("CustomDark"))
                            .padding(.top, 1)
                    }
                    Spacer()
                }//HStack
                .padding(.leading, 30)
                .padding(.top, 30)
                HStack{
                    Button(action: {
                        if store.tokens.ConsumableCount >= 5 {
                            showAlert = true
                            AlertValue = "Success"
                            store.buyFood()
                        }else{
                            showAlert = true
                            AlertValue = "Error"
                        }
                    }, label: {
                        VStack{
                            Image("FoodIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                            Text("Food")
                                .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/22))
                                .foregroundColor(Color("CustomDark"))
                            Text("5 Tokens")
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/30))
                                .foregroundColor(Color("CustomDark"))
                        }//VStack
                    })

                    Button(action: {
                        if store.tokens.ConsumableCount >= 1 {
                            showAlert = true
                            AlertValue = "Success"
                            store.buyEnergy()
                        }else{
                            showAlert = true
                            AlertValue = "Error"
                        }
                    }, label: {
                        VStack{
                            Image("EnergyIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                            Text("Energy")
                                .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/22))
                                .foregroundColor(Color("CustomDark"))
                            Text("1 Tokens")
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/30))
                                .foregroundColor(Color("CustomDark"))
                        }//VStack
                    })
 
                    Button(action: {
                        if store.tokens.ConsumableCount >= 3 {
                            showAlert = true
                            AlertValue = "Success"
                            store.buyHabitat()
                        }else{
                            showAlert = true
                            AlertValue = "Error"
                        }
                    }, label: {
                        VStack{
                            Image("HabitatIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                            Text("Habitat")
                                .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/22))
                                .foregroundColor(Color("CustomDark"))
                            Text("3 Tokens")
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/30))
                                .foregroundColor(Color("CustomDark"))
                        }//VStack
                    })
 
                    Button(action: {
                        if store.tokens.ConsumableCount >= 1 {
                            showAlert = true
                            AlertValue = "Success"
                            store.buyFun()
                        }else{
                            showAlert = true
                            AlertValue = "Error"
                        }
                    }, label: {
                        VStack{
                            Image("FunIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                            Text("Fun")
                                .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/22))
                                .foregroundColor(Color("CustomDark"))
                            Text("1 Tokens")
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/30))
                                .foregroundColor(Color("CustomDark"))
                        }//VStack
                    })

                    
                }//HStack
                .padding(.top)
            
                Spacer()
                
            }//VStack
        }//ZStack
        .alert(isPresented: $showAlert){
            Alert(title: Text( AlertValue == "Success" ? "Thank you for helping your animal" : "Oops something went wrong!"), message: Text(AlertValue == "Success" ? "Donating comes a long way in helping these animals form extinction" : "Please buy some tokens to adopt an Animal."), dismissButton: .default(Text("OK")){

            })
        }
        .onAppear(){
            self.vm.fetchAllAnimals()
        }//onappear

    }
    
}

struct MyAnimalsDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyAnimalsDetailScreenView(animal: AllAnimals(uid: "1", tagCode: "123456", species: "Shark", longitude: "1.10", latitude: "2.20", gender: "Male", age: 10, animalImage: "https://firebasestorage.googleapis.com:443/v0/b/animdo.appspot.com/o/animals%2FD5D5A4D1-1238-432D-ACA0-B22A32386FAB.jpg?alt=media&token=c8cf4ff6-ab58-413a-92a0-2363c919ac73", country: "South Africa", isoCode: "ZA", ocean: "atlantic", adopted: true, adoper: "1111", tokens: "1"))
    }
}

