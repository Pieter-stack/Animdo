//
//  UserViewModel.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/23.
//

import Foundation
import FirebaseFirestore
import Firebase

class SignedInUser: ObservableObject{
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    @Published var user: User?
    
    
    init(){
        fetchCurrentUser()
        print("init done")
    }
    
     func fetchCurrentUser(){
      
        guard let uid = auth.currentUser?.uid else { return }

        db.collection("users").document(uid).getDocument(completion: { [self] (snapshot, error) in
            if let error = error{
                print("Failed to fetch current user", error.localizedDescription)
                return
            }
            
            guard let data = snapshot?.data() else{ return }
            
            let uid = data["uid"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let surname = data["surname"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let gender = data["gender"] as? String ?? ""
            let age = data["age"] as? Int ?? 0
            let role = data["role"] as? String ?? ""
            let pfp = data["pfp"] as? String ?? ""
            
            user = User(uid: uid, name: name, surname: surname, username: username, email: email, gender: gender, age: age, role: role, pfp: pfp)

            print(user as Any)
            
        })
    }
        
}


