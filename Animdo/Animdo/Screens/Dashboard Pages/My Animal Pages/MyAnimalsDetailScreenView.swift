//
//  MyAnimalsDetailScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/31.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertX
import CoreLocation


struct MyAnimalsDetailScreenView: View {
    @ObservedObject private var vm = AllAnimalsViewModel()
    var device = UIDevice.current.name
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var store: IAPStore
    var animal : AllAnimals
    @State private var showAlert = false
    @State private var showGiftSheet = false
    @State private var AlertValue = ""
    @State private var animalName: String = ""
    //Location Manager
    @StateObject var locationManager = LocationManager()
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
     @State var distance: String = ""
    @State private var renameAnimal = false
    

    
    
    
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
                                let consumableCount = store.tokens.ConsumableCount
                                Text("\(consumableCount)")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                                    .foregroundColor(Color("White"))
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
                    Text("\(animal.name)?")
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
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                showGiftSheet = true
                            }, label: {
                                Image("GiftAnimal")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 40)
                            })
                        }//HStack
                        .padding(.trailing, 30)
                        .padding(.top, -20)
                        Spacer()
                    }//HStack
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
                NavigationLink(destination: MyAnimalMapScreenView(animal:animal).navigationBarBackButtonHidden(true), label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 90)
                            .fill(Color("CustomDark"))
                            .frame(width: getScreenBounds().width - 30, height: 60)
                        HStack{
                            Image("MapPinLight")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12)
                                .padding(.leading, 15)
                            if animal.country == ""{
                                Text("\(animal.ocean)")
                                    .padding(.top, 2)
                                    .padding(.leading, -8)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                            }else{
                                Text("\(animal.country), \(animal.isoCode)")
                                    .padding(.top, 2)
                                    .padding(.leading, -8)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                            }
                            Spacer()
                            Text("\(distance) km")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                .foregroundColor(.white)
                                .padding(.trailing, 20)
                            ZStack{
                                Circle()
                                    .fill(Color("CustomBlueLight"))
                                    .frame(width: 60)
                                Image(systemName: "chevron.right")
                                    .font(.title2)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                            }//ZStack
                            .padding(.trailing, -15)
                        }//HStack
                        .padding(.horizontal, 30)
                    }//ZStack
                })//Nav link
                
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
//        .alertX(isPresented: $showAlert, content: {
//
//                            AlertX(title: Text(AlertValue == "Success" ? "Thank you for helping your animal" : "Oops something went wrong!"),
//                                   message: Text(AlertValue == "Success" ? "Donating comes a long way in helping these animals form extinction" : "Please buy some tokens to help support your animal!"),
//
//                                   theme: AlertX.Theme.custom(windowColor: Color("CustomBlue"),
//                                                              alertTextColor: .white,
//                                                             enableShadow: true,
//                                                             enableRoundedCorners: true,
//                                                             enableTransparency: true,
//                                                              cancelButtonColor: .red,
//                                                              cancelButtonTextColor: .red,
//                                                              defaultButtonColor: Color("CustomBlueLighter"),
//                                                              defaultButtonTextColor: .black,
//                                                             roundedCornerRadius: 20),
//                                   animation: .classicEffect())
//                        })
        .onAppear(){
            self.vm.fetchAllAnimals()
            
            if animal.name == ""{
                renameAnimal.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let coordinate0 = CLLocation(latitude: Double(animal.latitude)!, longitude: Double(animal.longitude)!)
            let coordinate1 = CLLocation(latitude: Double(userLatitude)!, longitude: Double(userLongitude)!)

             let distancemeters = coordinate0.distance(from: coordinate1)
            let distanceKm = distancemeters / 1000
                distance = String(format: "%.2f", distanceKm)
            
                print("user long\(userLongitude)")
                print("user lat\(userLatitude)")
                print("animal long\(animal.longitude)")
                print("animal lat\(animal.latitude)")
            }
            
        }//onappear
        .fullScreenCover(isPresented: $renameAnimal, content: {
            NameAnimalScreenView(animal:animal)
        })
        .fullScreenCover(isPresented: $showGiftSheet, content: {
            GiftAnimalScreenView(animal:animal)
        })

    }
    
}



struct MyAnimalsDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyAnimalsDetailScreenView(animal: AllAnimals(uid: "1", name: "q", tagCode: "123456", species: "Shark", longitude: "1.10", latitude: "2.20", gender: "Male", age: 10, animalImage: "https://firebasestorage.googleapis.com:443/v0/b/animdo.appspot.com/o/animals%2FD5D5A4D1-1238-432D-ACA0-B22A32386FAB.jpg?alt=media&token=c8cf4ff6-ab58-413a-92a0-2363c919ac73", country: "South Africa", isoCode: "ZA", ocean: "atlantic", adopted: true, adoper: "1111", tokens: "1"))
    }
}


