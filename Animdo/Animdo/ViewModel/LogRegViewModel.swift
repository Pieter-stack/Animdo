//
//  LogRegViewModel.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/15.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn


class AuthManager: ObservableObject{

    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    @Published var message: String = ""
    
    func registerUser(email: String, password: String, name: String, surname: String, age: Int, gender: String, username: String ){
        auth.createUser(withEmail: email, password: password){ result, error in
            
            if (result != nil){
                print("Uid: \(result?.user.uid ?? "")")
                self.db.collection("users").document(result?.user.uid ?? "").setData([
                    "uid": result?.user.uid ?? "",
                    "name": name,
                    "surname":surname,
                    "age": age,
                    "gender": gender,
                    "username":username,
                    "email": email,
                    "role": "User"
                ]){err in
                    if let err = err {
                        print("Error writing user to document:\(err)")
                    }else{
                        print("User added")
                    }
                    
                }
            }
            
            if(error != nil){
                print(error.debugDescription)
                self.message = error?.localizedDescription ?? ""
                
            }
            
        }
    }
    
    func GoogleLogin(){
       //Google Signin
        
        guard let ClientID = FirebaseApp.app()?.options.clientID else{ return }
        //Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: ClientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()){user, error in
            
            if (error != nil){
                print(error!.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else{
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){result , error in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                
                guard let user = result?.user else{
                    return
                }
                
                if (result != nil){
                    print("Uid: \(result?.user.uid ?? "")")
                    let docRef = self.db.collection("users").document(result?.user.uid ?? "")
                    docRef.getDocument{ (document, error) in
                        if let document = document, document.exists{
                            print("user already in db")
                        }else{
                            
                            let fullName    = result?.user.displayName
                            let fullNameArr = fullName?.components(separatedBy: " ")

                            let name    = fullNameArr?[0]
                            let surname = fullNameArr?[1]
                            
                            
                            self.db.collection("users").document(result?.user.uid ?? "").setData([
                                "uid": result?.user.uid as Any,
                                "name": name as Any,
                                "surname": surname as Any,
                                "age": "age",
                                "gender": "gender",
                                "username":result?.user.displayName as Any,
                                "email": result?.user.email as Any,
                                "role": "User"
                            ]){err in
                                if let err = err {
                                    print("Error writing user to document:\(err)")
                                }else{
                                    print("User added")
                                }
                                
                            }
                        }
                    }
                }
                
                print(user.displayName ?? "Blank name")
            }
            
        }
    }
    
    //receiving Rootview Controller
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
    

    
    func loginUser(email: String, password: String){
            auth.signIn(withEmail: email, password: password) { [weak self] result, error in
          
            if (result != nil){
                print("signed in \(result?.user.uid ?? "")")
            }
            
            if(error != nil){
                print(error.debugDescription)
                self?.message = error?.localizedDescription ?? ""
                
            }
            
        }
    }
    
}
