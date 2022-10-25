//
//  HomeScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct HomeScreenView: View {
    @ObservedObject private var vm = SignedInUser()
    @AppStorage("loggedIn") var loggedIn: Bool = true
    

    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                HStack{
                    ZStack{
                        
                        WebImage(url: URL(string: vm.user?.pfp ?? "https://lh3.googleusercontent.com/a/ALm5wu2yT5NuPMaRICs2Jnq4-QhggyOWsmSVMeiCQRZm=s96-c"))
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
                        Text("\(vm.user?.name ?? "Pieter") \(vm.user?.surname ?? "Venter")")
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
                HStack{
                    VStack(alignment: .leading){
                        Text("Let's get")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                            .foregroundColor(Color("CustomBeige"))
                        Text("Adopting!")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/13))
                            .foregroundColor(.black)
                        Spacer()
                    }//VStack
                    .padding(.leading, 30)
                    Spacer()
                }//Hstack
                Spacer()
                HStack{
                    
                }//HStack
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
