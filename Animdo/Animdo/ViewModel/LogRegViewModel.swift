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
import CryptoKit
import AuthenticationServices
import FirebaseStorage


class AuthManager: ObservableObject{

    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    private var storage = Storage.storage()
    private var ImageUrl: String = ""
    private var load: Bool = false
    @Published var message: String = ""
    @Published var nonce = ""

    
    func resetPassword(email: String, resetCompletion: @escaping (Result<Bool,Error>) -> Void){
        auth.sendPasswordReset(withEmail: email, completion: {(error) in
            if let error = error {
                resetCompletion(.failure(error))
            }else{
                resetCompletion(.success(true))
            }
            
        }
    )}
    
    
    func registerUser(email: String, password: String, name: String, surname: String, age: Int, gender: String, username: String, image: UIImage){
        auth.createUser(withEmail: email, password: password){ [self] result, error in
            
                if (result != nil){
                    let uid = auth.currentUser?.uid
                    let storageRef = storage.reference()
                    let path = "images/\(uid ?? "").jpg"
                    let data = image.jpegData(compressionQuality: 0.8)
                    
                    // Create a reference to the file you want to upload
                    let ImageRef = storageRef.child(path)
                    
                    // Upload the file to the path
                    let metaData = StorageMetadata()
                    metaData.contentType = "image/jpeg"
                    _ = ImageRef.putData(data!, metadata: metaData) { (metadata, error) in
                        guard let metadata = metadata else {
                            print(error?.localizedDescription ?? "errror")
                            return
                        }
                        // Metadata contains file metadata such as size, content-type.
                        _ = metadata.size
                        // You can also access to download URL after upload.
                        ImageRef.downloadURL { (url, error) in
                            guard url != nil else {
                                print(error?.localizedDescription ?? "errror")
                                return
                            }
                            print(url ?? "url")
                            
                            self.db.collection("users").document(result?.user.uid ?? "").setData([
                                "uid": result?.user.uid ?? "",
                                "name": name,
                                "surname":surname,
                                "age": age,
                                "gender": gender,
                                "username":username,
                                "email": email,
                                "role": "User",
                                "pfp": url?.absoluteString as Any
                            ]){err in
                                if let err = err {
                                    print("Error writing user to document:\(err)")
                                }else{
                                    print("User added")
                                    self.load.toggle()
                                }
                                
                            }
                            
                        }
                    }
                }

                
                if(error != nil){
                    print(error.debugDescription)
                    self.message = error?.localizedDescription ?? ""
                    
                }
                
                
                
            }
        }
    
    

    func AppleLogin(credential: ASAuthorizationAppleIDCredential){
        
        var Name: String = ""
        var Surname: String = ""
        
       //getting Token
        guard let token = credential.identityToken else {
            print("error with firebase")
            return
        }
        
        //Token String
        guard let tokenString = String(data:token, encoding: .utf8) else{
            print("error with Token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        auth.signIn(with:firebaseCredential){(result, error) in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            if let _ = result?.user {
                let changeRequest = result?.user.createProfileChangeRequest()
                if let givenName = credential.fullName?.givenName,
                   let familyName = credential.fullName?.familyName{
                    Name = givenName
                    Surname = familyName
                    changeRequest?.displayName = "\(givenName) \(familyName)"
                }
                changeRequest?.commitChanges(completion: { (error) in
                    
                    if let error = error{
                        print(error.localizedDescription)
                    }else{
                        print("Updated display name: \(String(describing: changeRequest?.displayName))")
                    }
                    
                })
            }
            
            
            
            if (result != nil){
                print("Uid: \(result?.user.uid ?? "")")
                let docRef = self.db.collection("users").document(result?.user.uid ?? "")
                docRef.getDocument{ (document, error) in
                    if let document = document, document.exists{
                        print("user already in db")
                    }else{
                        

                        
                        
                        self.db.collection("users").document(result?.user.uid ?? "").setData([
                            "uid": result?.user.uid as Any,
                            "name": Name,
                            "surname": Surname,
                            "age": "unknown",
                            "gender": "unknown",
                            "username":"\(Name) \(Surname)",
                            "email": result?.user.email as Any,
                            "role": "User",
                            //pfp not with apple restrict access
                            "pfp": ""
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
            
            
            //User Success
            print("Logged in through apple")
                        
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
                                "age": "unknown",
                                "gender": "unknown",
                                "username":result?.user.displayName as Any,
                                "email": result?.user.email as Any,
                                "role": "User",
                                "pfp": result?.user.photoURL?.absoluteString as Any
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

    func persistImageToStorage(){
        print("Hello there")
    }
    
}


//helpers from apple login with firebase

 func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

 func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}

