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
    

    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                
                WebImage(url: URL(string: vm.user?.pfp ?? ""))
                Text("Current user: \(vm.user?.name ?? "")")
                Text("Current user: \(vm.user?.pfp ?? "no image found")")
                Text("Home View")
                Text("\(Auth.auth().currentUser?.uid ?? "")")
                Button(action: {
                    try? Auth.auth().signOut()
                }, label: {
                    Text("Logout")
                })
            }//VStack
        }//ZStack




        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
