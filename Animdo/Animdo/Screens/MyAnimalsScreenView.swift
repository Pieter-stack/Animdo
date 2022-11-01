//
//  MyAnimalsScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI


struct MyAnimalsScreenView: View {
    var device = UIDevice.current.name
    @ObservedObject private var vm = AllAnimalsViewModel()
    @State var index: Int = 0
    @State private var filterSearch = "ALL"
    var body: some View {
            ZStack{
                Color("BG")
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("My")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                                .foregroundColor(Color("CustomBeige"))
                            Text("Animal Friends")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                                .foregroundColor(.black)
                 
                            
                        }//VStack
                        Spacer()
                    }//HStack
                    .padding(.leading, 30)
                    .padding(.top, 20)
                    HStack{
                        ZStack{
                            ScrollView(showsIndicators: false){
                                Button(action: {
                                    filterSearch = "ALL"
                                }, label: {
                                    ZStack{
                                        Circle()
                                            .fill(Color("CustomGreenLighter"))
                                            .frame(width: filterSearch == "ALL" ? 70 : 50)
                                        Text("All")
                                            .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/24))
                                            .foregroundColor(.black)
                                            .padding(.top, 5)
                                    }//ZStack
                                })
                                .padding(.vertical, 5)
                                
                                Button(action: {
                                    filterSearch = "Lion"
                                }, label: {
                                    FilterBtnMyAnimals(image: "LionIcon", color: "CustomBrown", size: filterSearch == "Lion" ? 70 : 50, sizeIcon: filterSearch == "Lion" ? 35 : 25)
                                })
                                .padding(.vertical, 5)
                                Button(action: {
                                    filterSearch = "Polar Bear"
                                }, label: {
                                    FilterBtnMyAnimals(image: "PolarBearIcon", color: "CustomBlueLight", size: filterSearch == "Polar Bear" ? 70 : 50, sizeIcon: filterSearch == "Polar Bear" ? 35 : 25)
                                })
                                .padding(.vertical, 5)
                                Button(action: {
                                    filterSearch = "Elephant"
                                }, label: {
                                    FilterBtnMyAnimals(image: "ElephantIcon", color: "CustomBrown", size: filterSearch == "Elephant" ? 70 : 50, sizeIcon: filterSearch == "Elephant" ? 35 : 25)
                                })
                                .padding(.vertical, 5)
                                Button(action: {
                                    filterSearch = "Penguin"
                                }, label: {
                                    FilterBtnMyAnimals(image: "PenguinIcon", color: "CustomBlueLight", size: filterSearch == "Penguin" ? 70 : 50, sizeIcon: filterSearch == "Penguin" ? 35 : 25)
                                })
                                Button(action: {
                                    filterSearch = "Sea Turtle"
                                }, label: {
                                    FilterBtnMyAnimals(image: "SeaTurtleIcon", color: "CustomGreenLighter", size: filterSearch == "Sea Turtle" ? 70 : 50, sizeIcon: filterSearch == "Sea TTurtle" ? 35 : 25)
                                })
                                .padding(.vertical, 5)
                                Button(action: {
                                    filterSearch = "Shark"
                                }, label: {
                                    FilterBtnMyAnimals(image: "SharkIcon", color: "CustomBlueLight", size: filterSearch == "Shark" ? 70 : 50, sizeIcon: filterSearch == "Shark" ? 35 : 25)
                                })
                                .padding(.vertical, 5)
                                
                            }//ScrollView
                            .padding(.top, 35)
                            .padding(.horizontal, 30)
                        }//ZStack
                        .zIndex(100)

                        
                        Spacer()
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                ForEach(vm.animals){animal in
                                    if animal.adoper == Auth.auth().currentUser?.uid {
                                        if animal.species == filterSearch{
                                            NavigationLink(destination: MyAnimalsPurchaseFail(animal: animal).navigationBarBackButtonHidden(true), label: {
                                                MyAnimalComp(image: animal.animalImage, name: animal.name, species: animal.species, country: animal.country, ocean: animal.ocean, isoCode: animal.isoCode, color: animal.species == "Lion" || animal.species == "Elephant" ? "CustomBrownLight" : animal.species == "Polar Bear" || animal.species == "Penguin" || animal.species == "Shark" ? "CustomBlueLighter" : animal.species == "Sea Turtle" ? "CustomGreenLighter" : "CustomGreenLighter", colorSecondary: animal.species == "Lion" || animal.species == "Elephant" ? "CustomBrown" : animal.species == "Polar Bear" || animal.species == "Penguin" || animal.species == "Shark" ? "CustomBlue" : animal.species == "Sea Turtle" ? "CustomGreen" : "CustomGreen")
                                                    .padding(.trailing, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 135 : 150)
                                                    .padding(.leading, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 25 : 0)
                                           })//navlink
                                            
                                        }else if filterSearch == "ALL"{
                                            NavigationLink(destination: MyAnimalsPurchaseFail(animal:animal).navigationBarBackButtonHidden(true), label: {
                                                    MyAnimalComp(image: animal.animalImage,name: animal.name, species: animal.species, country: animal.country, ocean: animal.ocean, isoCode: animal.isoCode, color: animal.species == "Lion" || animal.species == "Elephant" ? "CustomBrownLight" : animal.species == "Polar Bear" || animal.species == "Penguin" || animal.species == "Shark" ? "CustomBlueLighter" : animal.species == "Sea Turtle" ? "CustomGreenLighter" : "CustomGreenLighter", colorSecondary: animal.species == "Lion" || animal.species == "Elephant" ? "CustomBrown" : animal.species == "Polar Bear" || animal.species == "Penguin" || animal.species == "Shark" ? "CustomBlue" : animal.species == "Sea Turtle" ? "CustomGreen" : "CustomGreen")
                                                        .padding(.trailing, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 135 : 150)
                                                        .padding(.leading, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 25 : 0)
                                                })//navlink
                                            
                                            
                                        }
                                    }//if
                                }//foreach
                                }//HStack
                                .padding(.bottom, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 60 : 50)
                                .padding(.trailing, -150)
                          
                            }//Scrollview
                            .padding(.trailing, 100)
                            .padding(.bottom, 100)
                            .cornerRadius(150)
                            .padding(.trailing, -100)
                            .padding(.bottom, -100)
                       
                    }//HStack
                    .padding(.bottom, 150)
                    ZStack{
                        HStack{
                            Spacer()
                            Image("SwipeArrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 60 : 90)
                        }//HStack
                        .padding(.top, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? -220  : -280)
                        .padding(.trailing, 25)
                    }//ZStack
                    .zIndex(100)
                    VStack{
                        HStack{
                            if filterSearch == "ALL"{
                                
                            }else if filterSearch == "Lion"{
                                Text("About Lions")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                    .foregroundColor(Color("CustomBeige"))
                                    .padding(.leading, 30)
                            }else if filterSearch == "Polar Bear"{
                                Text("About Polar Bears")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                    .foregroundColor(Color("CustomBeige"))
                                    .padding(.leading, 30)
                            }else if filterSearch == "Elephant"{
                                Text("About Elephants")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                    .foregroundColor(Color("CustomBeige"))
                                    .padding(.leading, 30)
                            }else if filterSearch == "Penguin"{
                                Text("About Penguins")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                    .foregroundColor(Color("CustomBeige"))
                                    .padding(.leading, 30)
                            }else if filterSearch == "Sea Turtle"{
                                Text("About Sea Turtles")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                    .foregroundColor(Color("CustomBeige"))
                                    .padding(.leading, 30)
                            }else if filterSearch == "Shark"{
                                Text("About Sharks")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                    .foregroundColor(Color("CustomBeige"))
                                    .padding(.leading, 30)
                            }
                            

                            Spacer()
                        }//HStack
                        HStack{
                            ScrollView{
                                if filterSearch == "ALL"{
                                    
                                }else if filterSearch == "Lion"{
                                    Text("Unlike other cats, lions are very social animals. They live in groups, called prides, of around 30 lions. ")
                                        .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/24))
                                        .foregroundColor(Color("CustomDark"))
                                        .padding(.horizontal, 30)
                                }else if filterSearch == "Polar Bear"{
                                    Text("The largest bear in the world and the Arctic's top predator, polar bears are a powerful symbol of the strength and endurance of the Arctic.")
                                        .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/24))
                                        .foregroundColor(Color("CustomDark"))
                                        .padding(.horizontal, 30)
                                }else if filterSearch == "Elephant"{
                                    Text("Elephants are the largest existing land animals. Distinctive features of elephants include a long proboscis called a trunk, tusks, large ear flaps, pillar-like legs, and tough but sensitive skin.")
                                        .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/24))
                                        .foregroundColor(Color("CustomDark"))
                                        .padding(.horizontal, 30)
                                }else if filterSearch == "Penguin"{
                                    Text("Penguins are flightless seabirds that live almost exclusively below the equator. Some island-dwellers can be found in warmer climates, but most penguins—reside in and around icy Antarctica.")
                                        .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/24))
                                        .foregroundColor(Color("CustomDark"))
                                        .padding(.horizontal, 30)
                                }else if filterSearch == "Sea Turtle"{
                                    Text("Sea turtles, sometimes called marine turtles and are reptiles. The seven existing species of sea turtles are the flatback, green, hawksbill, leatherback, loggerhead, Kemp's ridley, and olive ridley sea turtles.")
                                        .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/24))
                                        .foregroundColor(Color("CustomDark"))
                                        .padding(.horizontal, 30)
                                }else if filterSearch == "Shark"{
                                    Text("There are over 500 species of sharks. Like other fishes, sharks are cold-blooded, have fins, live in the water, and breathe with gills.")
                                        .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/24))
                                        .foregroundColor(Color("CustomDark"))
                                        .padding(.horizontal, 30)
                                }
                            }.frame(height: 70)
                            Spacer()
                        }//HStack
                    }//VStack
                    .padding(.top, -190)
                    
                   
                    Spacer()
                    
                    
                }//VStack
            }//ZStack
            .onAppear(){
                self.vm.fetchAllAnimals()
            }//onappear
        
    }
}

struct MyAnimalsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyAnimalsScreenView()
    }
}





