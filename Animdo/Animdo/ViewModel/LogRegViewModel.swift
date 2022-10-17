//
//  LogRegViewModel.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/15.
//

import Foundation
import Firebase
import FirebaseAuth

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
