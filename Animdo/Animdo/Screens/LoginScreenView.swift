//
//  LoginScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/10.
//

import SwiftUI

struct LoginScreenView: View {

    var device = UIDevice.current.name
    //Input fields
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var AllFields: Int = 0
    
    @State private var showForgotPassword = false
    
    
   
    var body: some View {
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
                    .padding(.bottom,getScreenBounds().width/130 )
                    
                    //TODO: forgot pw need to move to correct area
                    Button(action: {
                        //TODO: Handle presentation to forgot password
                        showForgotPassword.toggle()
                        
                    }, label: {
                        Text("forgot password?")
                    })
                    
                    
    
                    
                    ZStack(alignment: .leading){
                        if email.isEmpty{
                            Text("Email")
                                .padding(.all, 20)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                .foregroundColor(.white).opacity(0.5)
                                .padding(.bottom, -50)
                        }
                        TextField("", text: $email)
                            .padding(.all, 20)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                            .foregroundColor(.white)
                            .padding(.bottom, -50)
                    }//ZStack
            
                    if email.isEmpty{
                        HStack{
                            Text("")
                                .padding(.all, 20)
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 5)
                                .padding()
                                .padding(.leading, -50)
                        }//HStack
                    }else{
                        HStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("CustomBlueLight"))
                                .frame(width: 30, height: 5)
                                .padding(.leading)
                                
                            Text("Email")
                                .padding(.all, 20)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                .foregroundColor(.white.opacity(0.5))
                                .padding(.horizontal, -20)
                            
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 5)
                                .padding(.trailing)
                        }//HStack
                    }//Custom Input Line
                    
                    ZStack(alignment: .leading){
                        if password.isEmpty{
                            Text("Password")
                                .padding(.all, 20)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                .foregroundColor(.white).opacity(0.5)
                                .padding(.bottom, -50)
                        }
                        TextField("", text: $password)
                            .padding(.all, 20)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                            .foregroundColor(.white)
                            .padding(.bottom, -50)
                    }//ZStack
            
                    if password.isEmpty{
                        HStack{
                            Text("")
                                .padding(.all, 20)
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 5)
                                .padding()
                                .padding(.leading, -50)
                        }//HStack
                    }else{
                        HStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("CustomBlueLight"))
                                .frame(width: 30, height: 5)
                                .padding(.leading)
                                
                            Text("Password")
                                .padding(.all, 20)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                .foregroundColor(.white.opacity(0.5))
                                .padding(.horizontal, -20)
                            
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 5)
                                .padding(.trailing)
                        }//HStack
                    }//Custom Input Line
                Spacer()
                
                    VStack{
                        if AllFields == 1{
                            Text("Please fill in all the fields!")
                                .foregroundColor(.yellow)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                        }

                    Button(action:{
                        if (email.isEmpty || password.isEmpty ){
                            AllFields = 1
                            
                        }else{
                            AllFields = 0
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
        .sheet(isPresented: $showForgotPassword, content: {
            ForgotPasswordScreenView()
        })
    }//body
}//loginscreenview

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
