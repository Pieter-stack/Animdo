//
//  MyAnimalsScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI
import FirebaseAuth
import StoreKit

struct MyAnimalsScreenView: View {
    @AppStorage("loggedIn") var loggedIn: Bool = true
    var body: some View {
            ZStack{
                Color("BG")
                    .ignoresSafeArea()
                VStack{ 
                Button(action: {
                    try? Auth.auth().signOut()
                    loggedIn = false
                }, label: {
                    Text("Logout")
                })
                }
            }//ZStack
        
    }
}

struct MyAnimalsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyAnimalsScreenView()
    }
}



