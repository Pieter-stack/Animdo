//
//  LoginScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/10.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices

struct LoginScreenView: View {
    @State var userIsLoggedIn: Bool = false
    @AppStorage("loggedIn") var loggedIn: Bool = true
    @StateObject var authManager = AuthManager()
    var device = UIDevice.current.name
    //Input fields
    @State private var pwVisible: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var AllFields: Int = 0
    @State private var loader: Bool = false
    
    @State private var showForgotPassword = false
    
    
   
    var body: some View {
        if userIsLoggedIn{
                DashboardScreenView()
        }else{
                content
        }
    }//body
    
    var content: some View{
        GeometryReader{metrics in
            ZStack{
                Image("LoginBG")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    Image("LoginImg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: getScreenBounds().width - 100)
                    Spacer()

                    Text("Login")
                    .foregroundColor(.white)
                    .font(Font.custom("Aladin-regular", size: getScreenBounds().width/9))
                    .underline()
                    .padding(.bottom,getScreenBounds().width/100 )
                    .padding(.top, 40)
                    
                    

                    
                    
                    LogRegInputs(input: $email, keyboardType: .default, placeholder: "Email")
                    
                    PasswordInputs(input: $password, visible: $pwVisible, keyboardType: .default, placeholder: "Password").padding(.bottom, -10)
                    //TODO: forgot pw need to move to correct area
                    VStack(alignment: .trailing){
                        Button(action: {
                            //TODO: Handle presentation to forgot password
                            showForgotPassword.toggle()
                            
                        }, label: {
                            Text("Forgot password?")
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                        })
                        .padding(.top, -10)
                        .padding(.trailing)
                    }
                    .frame(width: getScreenBounds().width, alignment: .trailing)
                    
                    Spacer()
                    
                    HStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("CustomBlueLight"))
                            .frame(height: 5)
                            .padding()
                            .padding(.leading, 50)
                        
                        Button(action: {
                            authManager.GoogleLogin()
                        }, label: {
                            Image("Google")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28)
                                .frame(width: 65, height: 35)
                                .background(.white)
                                .cornerRadius(40)
                        })
                        Image(systemName: "applelogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 20)
                            .padding(.bottom,5)
                            .frame(width: 65, height: 35)
                            .background(.black)
                            .cornerRadius(40)
                            .overlay(
                            
                                SignInWithAppleButton{ (request) in
                                    //requesting paramaters from apple
                                    //no pfp so have default one
                                    authManager.nonce = randomNonceString()
                                    request.requestedScopes=[.email,.fullName]
                                    request.nonce = sha256(authManager.nonce)
                                    
                                    
                                } onCompletion:{(result) in
                                    //getting error or success
                                    switch result{
                                    case .success(let user):
                                        print("success")
                                        //do login with firebase
                                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                                            print("error with firebase")
                                            return
                                        }
                                        authManager.AppleLogin(credential: credential)
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                    
                                }.signInWithAppleButtonStyle(.black)
                                    .frame(width: 65)
                                    .clipShape(Capsule())
                                    .opacity(0.02)
                            )
                        
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("CustomBlueLight"))
                            .frame(height: 5)
                            .padding()
                            .padding(.trailing, 50)

  
                    }
                    .padding(.bottom, AllFields == 1 ? 20 : -16)
                    .padding(.top, 5)
                    
                Spacer()
                
                    VStack{
                        if AllFields == 1{
                            Text("Please fill in all the fields!")
                                .foregroundColor(.yellow)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }else{
                            Text("\(authManager.message == "There is no user record corresponding to this identifier. The user may have been deleted." ? "Email does not exist or does not match with password" : authManager.message )")
                                .foregroundColor(.yellow)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }
                        
                        if loader == false{
                        
                        Button(action:{
                            if (email.isEmpty || password.isEmpty ){
                                AllFields = 1
                                
                            }else{
                                AllFields = 0
                                authManager.loginUser(email: email, password: password)
                                loader = true
                            }
                            
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color("CustomBlueLight"))
                                    .frame(height: 60)
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                                Text("Login")
                                    .foregroundColor(.white)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                    .padding(.top, 20)
                            }//ZStack
                        })
                        .accessibilityIdentifier("loginButton")
                        
                    }else{

                            ZStack{
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color("CustomBlueLighter"))
                                    .frame(height: 60)
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                                LottieView(filename: "Loading")
                                    .aspectRatio(contentMode: .fit)
                                      .frame(width: 80, height: 80)
                                      .padding(.top, 20)
                            }//ZStack

                        
                    }
                        
                        HStack{
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/23))
                            NavigationLink(destination: OnboardingRegisterScreenView().navigationBarBackButtonHidden(true)){
                                Text("Register here")
                                    .foregroundColor(.white)
                                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/23))
                            }//NavigationLink
                        }//Hstack
                        .padding(.top, 5)
                        .padding(.bottom, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 10 : 0 )
                    }//VStack
                    .padding(.top,device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 75 :  -65)
                }//VStack
            }//ZStack
        }//georeader
        .onAppear{
            Auth.auth().addStateDidChangeListener{auth, user in
                if loggedIn{
                    if user != nil {
                        withAnimation{
                                userIsLoggedIn = true
                                loggedIn = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                loader = false
                            }
                        }//animation
                    }//if user is not nil
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    print("Async after 4 seconds")
                if user != nil {
                    withAnimation{
                            userIsLoggedIn = true
                            loggedIn = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            loader = false
                        }
                        
                        }
                    }//animation
                }//if user is not nil
            }
                
            }//listening state
        }//on appear
        .fullScreenCover(isPresented: $showForgotPassword, content: {
            ForgotPasswordScreenView()
        })
    }
}//loginscreenview

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
