//
//  AdoptionDashScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertX

struct AdoptionDashScreenView: View {
    @ObservedObject private var vm = AllAnimalsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var store: IAPStore
    @State private var showAlert = false
    @State private var AlertValue = ""
//    @State var filterSearch = "ALL"
    
//    init(){
//        self.vm.fetchAllAnimals()
//    }
    @Binding var filterSearch: String
    
    var vGridLayout: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 200),spacing: 10)]
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
//                                Text("\(store.tokens.ConsumableCount)")
//                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
//                                    .foregroundColor(Color("White"))
                            }
                            .padding(.top, -10)
                        }
                    }
                }
                .ignoresSafeArea()
                
                

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
                    .padding(.top, -80)
                    

                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 15){
                                Button(action: {
                                    filterSearch = "ALL"
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("CustomGreenLighter"))
                                            .frame(width: 60, height: 40)
                                        Text("All")
                                            .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/24))
                                            .foregroundColor(.black)
                                            .padding(.top, 5)
                                    }//ZStack
                                })
                                .padding(.bottom, filterSearch == "ALL" ? 20 : 0)
                                Button(action: {
                                    filterSearch = "Lion"
                                }, label: {
                                    FilterBtnAdoption(image: "LionIcon", color: "CustomBrown")
                                        .padding(.bottom, filterSearch == "Lion" ? 20 : 0)
                                })
                                Button(action: {
                                    filterSearch = "Polar Bear"
                                }, label: {
                                    FilterBtnAdoption(image: "PolarBearIcon", color: "CustomBlueLight")
                                        .padding(.bottom, filterSearch == "Polar Bear" ? 20 : 0)
                                })
                                Button(action: {
                                    filterSearch = "Elephant"
                                }, label: {
                                    FilterBtnAdoption(image: "ElephantIcon", color: "CustomBrown")
                                        .padding(.bottom, filterSearch == "Elephant" ? 20 : 0)
                                })
                                Button(action: {
                                    filterSearch = "Penguin"
                                }, label: {
                                    FilterBtnAdoption(image: "PenguinIcon", color: "CustomBlueLight")
                                        .padding(.bottom, filterSearch == "Penguin" ? 20 : 0)
                                })
                                Button(action: {
                                    filterSearch = "Sea Turtle"
                                }, label: {
                                    FilterBtnAdoption(image: "SeaTurtleIcon", color: "CustomGreenLighter")
                                        .padding(.bottom, filterSearch == "Sea Turtle" ? 20 : 0)
                                })
                                Button(action: {
                                    filterSearch = "Shark"
                                }, label: {
                                    FilterBtnAdoption(image: "SharkIcon", color: "CustomBlueLight")
                                        .padding(.bottom, filterSearch == "Shark" ? 20 : 0)
                                })
                                
                            }//HStack
                        }//ScrollView
                        .padding(.horizontal)
                        .padding(.top, -15)
                        .padding(.bottom, 35)
                    
                    
                    ScrollView{
                        LazyVGrid(columns: vGridLayout){
                            ForEach(vm.animals){animal in
                                
                                if animal.adopted == true{
                                  //if animal adopted take out of adoption pool
                                }else{
                                    //if for filtering here
                                  
                                    if filterSearch == "ALL"{
                                        Button(action: {
                                            if store.tokens.ConsumableCount >= Int(animal.tokens)! {
                                                showAlert = true
                                                AlertValue = "Success"
                                                vm.adoptAnimal(animaluid: animal.uid)
                                                store.buyTokens(tokenamount: animal.tokens)
                                            }else{
                                                showAlert = true
                                                AlertValue = "Error"
                                            }
                                            
                                        }, label: {
                                            AdoptionCard(image: animal.animalImage, species: animal.species, age: animal.age, country: animal.country, ocean: animal.ocean, isoCode: animal.isoCode, tokens: animal.tokens)
                                        })
                                    }else if animal.species == filterSearch{
                                      
                                            Button(action: {
                                                if store.tokens.ConsumableCount >= Int(animal.tokens)! {
                                                    showAlert = true
                                                    AlertValue = "Success"
                                                    vm.adoptAnimal(animaluid: animal.uid)
                                                    store.buyTokens(tokenamount: animal.tokens)
                                                }else{
                                                    showAlert = true
                                                    AlertValue = "Error"
                                                }
                                                
                                            }, label: {
                                                AdoptionCard(image: animal.animalImage, species: animal.species, age: animal.age, country: animal.country, ocean: animal.ocean, isoCode: animal.isoCode, tokens: animal.tokens)
                                            })
                                        }
                                }//else
                            }//foreach
                        }//lazyvgrid
                    }//scrollview
                    .padding(.top, 10)
                    .cornerRadius(35)
                    .padding(.top, -10)
                    .padding(.bottom, 75)

                    Spacer()
                }//VStack
            }//Vstack
        }//ZStack
        .onAppear(){
            self.vm.fetchAllAnimals()
        }//onappear
        .alertX(isPresented: $showAlert, content: {
                            
                            AlertX(title: Text(AlertValue == "Success" ? "Animal Adopted" : "Oops something went wrong!"),
                                   message: Text(AlertValue == "Success" ? "Thank you for rescuing an Animal." : "Please buy some tokens to adopt an Animal."),
     
                                   theme: AlertX.Theme.custom(windowColor: Color("CustomBlue"),
                                                              alertTextColor: .white,
                                                             enableShadow: true,
                                                             enableRoundedCorners: true,
                                                             enableTransparency: true,
                                                              cancelButtonColor: .red,
                                                              cancelButtonTextColor: .red,
                                                              defaultButtonColor: Color("CustomBlueLighter"),
                                                              defaultButtonTextColor: .black,
                                                             roundedCornerRadius: 20),
                                   animation: .classicEffect())
                        })
        
    }//body
}//struct


struct AdoptionDashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionDashScreenView(filterSearch: .constant("ALL"))
    }
}
