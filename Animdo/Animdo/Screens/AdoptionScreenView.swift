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
    @EnvironmentObject private var store: IAPStore
    @State private var showAlert = false
    @State private var AlertValue = ""
    
    init(){
        self.vm.fetchAllAnimals()
    }
    
    var vGridLayout: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 200),spacing: 10)]
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                HStack{
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
                                Text("555")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                                    .foregroundColor(Color("White"))
                            }
                            .padding(.top, -10)
                        }
                    }
                }
                .ignoresSafeArea()
                
                
//                Image(systemName: "\(store.tokens.ConsumableCount).circle")
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
                    
                    HStack{
                        Text("hhhhh")
                    }
                    
                    ScrollView{
                        LazyVGrid(columns: vGridLayout){
                            ForEach(vm.animals){animal in
                                
                                if animal.adopted == true{
                                  //if animal adopted take out of adoption pool
                                }else{
                                    //if for filtering here
                                    
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
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.white)
                                            .frame(height: 330)
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
                                                .padding(.leading, 20)
                                                .padding(.trailing, 15)
                                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                                                    .foregroundColor(.black)
                                            
                                            Text("\(animal.age) years old")
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
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("CustomBlueLight"))
                                                .frame(height: 2)
                                                .padding(.horizontal)
                                            Spacer()
                                            
                                            HStack{
                                                Text("12 Tokens")
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
                                    })
                                    
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
        .alert(isPresented: $showAlert){
            Alert(title: Text( AlertValue == "Success" ? "Animal Adopted" : "Oops something went wrong!"), message: Text(AlertValue == "Success" ? "Thank you for rescuing an Animal." : "Please buy some tokens to adopt an Animal."), dismissButton: .default(Text("OK")){
            })
        }
        
    }//body
}//struct

struct AdoptionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionScreenView()
    }
}



