//
//  HomeScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
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
