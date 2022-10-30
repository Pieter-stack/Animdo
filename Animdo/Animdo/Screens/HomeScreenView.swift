//
//  HomeScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI
import FirebaseAuth
import SDWebImage
import SDWebImageSwiftUI

struct HomeScreenView: View {
    @ObservedObject private var vm = SignedInUser()
    @AppStorage("loggedIn") var loggedIn: Bool = true
    var device = UIDevice.current.name
    

    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                HStack{
                    ZStack{
                        
                        WebImage(url: URL(string: vm.user?.pfp ?? ""))
                            .resizable()
                            .aspectRatio(1,contentMode: .fit)
                            .frame(width: getScreenBounds().width/5)
                            .mask(
                                Image("PfpTemplate")
                                    .resizable()
                                    .aspectRatio(1,contentMode: .fit)
                                    .frame(width: getScreenBounds().width/5)
                                    .allowsHitTesting(false)
                                    .padding(.bottom, 8)
                            )
                        Image("RingPfp")
                            .resizable()
                            .aspectRatio(1,contentMode: .fit)
                            .frame(width: getScreenBounds().width/4)
                            .allowsHitTesting(false)
                            .padding(.bottom, 40)
                            .padding(.trailing)
                    }//ZStack
                    VStack(alignment: .leading){
                        Text("Welcome,")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                            .foregroundColor(Color("CustomBeige"))
                        Text("\(vm.user?.name ?? "") \(vm.user?.surname ?? "")")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                            .foregroundColor(.black)
                    }//VStack
                    .padding(.leading, -20)
                    Spacer()
                    NavigationLink(destination: SettingsScreenView().navigationBarBackButtonHidden(true)){
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("CustomBeige"))
                            .frame(width: 30)
                            .padding(.trailing, 20)
                    }
                }//HStack
                .padding(.top, -30)
                HStack{
                    VStack(alignment: .leading){
                        Text("Let's get")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                            .foregroundColor(Color("CustomBeige"))
                        Text("Adopting!")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/13))
                            .foregroundColor(.black)
                    }//VStack
                    .padding(.leading, 30)
                    Spacer()
                }//Hstack
                HStack{
                    ScrollView{
                        ForEach(dashAnimals){ animal in
                            NavigationLink(destination: DashboardDetailScreenView(animal: animal).navigationBarBackButtonHidden(true), label: {
                            ZStack{
                                Image(animal.coverImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: getScreenBounds().width/2.1, height: getScreenBounds().width/2.1)
                                    .padding(5)
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                            ZStack{
                                                Rectangle()
                                                    .frame(width: 50, height: 40)
                                                    .foregroundColor(Color(animal.primaryColor))
                                                    .padding(.bottom, 17)
                                                    .padding(.trailing, 17)
                                                    .cornerRadius(17)
                                                    .padding(.bottom, -17)
                                                    .padding(.trailing, -17)
                                                    .padding(.top, 17)
                                                    .padding(.leading, 17)
                                                    .cornerRadius(17)
                                                    .padding(.top, -17)
                                                    .padding(.leading, -17)
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(Color(animal.iconColor))
                                                    .font(.title2)
                                                    .fontWeight(.black)
                                            }//ZStack
                                    }//HStack
                                }//VStack
                                .padding(.bottom, 5)
                                .padding(.trailing, 11)
                            }//ZStack
                            })//NavigationLink
                        }//foreach
                        
                    }//Scrollview
                    .padding(.top, 10)
                    .cornerRadius(35)
                    .padding(.top, -10)
                    .frame(width: getScreenBounds().width/1.9)
                    .padding(.bottom, 119)
                
                    Spacer()
                    Image("DashboardBG")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: getScreenBounds().width/2)
                        .padding(.trailing,  device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? -35 : -25 )
                        .padding(.top, -80)

                    
                }//HStack
                .ignoresSafeArea()
            }//VStack
        }//ZStack





        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}




//                WebImage(url: URL(string: vm.user?.pfp ?? ""))
//                Text("Current user: \(vm.user?.name ?? "")")
//                Text("Current user: \(vm.user?.pfp ?? "no image found")")
//                Text("Home View")
//                Text("\(Auth.auth().currentUser?.uid ?? "")")
//                Button(action: {
//                    try? Auth.auth().signOut()
//                    loggedIn = false
//                }, label: {
//                    Text("Logout")
//                })
