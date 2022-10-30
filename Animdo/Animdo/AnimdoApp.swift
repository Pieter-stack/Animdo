//
//  AnimdoApp.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/08.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SwiftKeychainWrapper


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any])-> Bool{
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main

struct AnimdoApp: App {
    init(){
//        KeychainWrapper.standard.removeAllKeys()
    }
    
    //register app delegate for firbase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
