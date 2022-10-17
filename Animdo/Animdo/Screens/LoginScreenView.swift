//
//  LoginScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/10.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginScreenView: View {
    @State var userIsLoggedIn: Bool = false
    @StateObject var authManager = AuthManager()
    var device = UIDevice.current.name
    //Input fields
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var AllFields: Int = 0
    
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
                    .padding(.top, 30)
                    
                    

                    
                    
                    LogRegInputs(input: $email, keyboardType: .default, placeholder: "Email")
                    LogRegInputs(input: $password, keyboardType: .default, placeholder: "Password")
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
                        .padding(.top, -20)
                        .padding(.trailing)
                    }
                    .frame(width: getScreenBounds().width, alignment: .trailing)
                    
                    
                    
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

                    Button(action:{
                        if (email.isEmpty || password.isEmpty ){
                            AllFields = 1
                            
                        }else{
                            AllFields = 0
                            authManager.loginUser(email: email, password: password)
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
                if user != nil {
                    withAnimation{
                        userIsLoggedIn.toggle()
                    }//animation
                }//if user is not nil
            }//listening state
        }//on appear
        .sheet(isPresented: $showForgotPassword, content: {
            ForgotPasswordScreenView()
        })
    }
}//loginscreenview

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
