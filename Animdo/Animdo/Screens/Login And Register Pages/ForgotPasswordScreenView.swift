//
//  ForgotPasswordScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/13.
//

import SwiftUI
import FirebaseAuth
import AlertX

struct ForgotPasswordScreenView: View {
    @StateObject var authManager = AuthManager()
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var errString: String?
    
    var body: some View {
        ZStack{
            Image("LoginBG")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("Reset Password")
                .foregroundColor(.white)
                .font(Font.custom("Aladin-regular", size: getScreenBounds().width/9))
                .underline()
                .padding(.bottom,getScreenBounds().width/100 )
                .padding(.top, 40)
                Spacer()
                
                Text("Enter the email associated with your account and we'll send an email with instructions to reset your password.")
                    .foregroundColor(.white)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                    .padding(.bottom, 150)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .lineSpacing(1.2)

                LogRegInputs(input: $email, keyboardType: .emailAddress, placeholder: "Email")
                
                Button(action:{
                    authManager.resetPassword(email: email){(result) in
                        switch result{
                        case .failure(let error):
                            self.errString = error.localizedDescription
                        case .success( _):
                            break
                        }
                        self.showAlert = true
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color("CustomBlueLight"))
                            .frame(height: 60)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        Text("Reset Password")
                            .foregroundColor(.white)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                            .padding(.top, 20)
                    }//ZStack
                })
                .padding(.bottom, 30)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("I remembered my Password")
                        .foregroundColor(.white)
                        .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/23))
                    
                })
                
            }//VStack
        }//ZStack
        .alertX(isPresented: $showAlert, content: {
                            AlertX(title: Text("Password Reset"),
                                   message: Text(self.errString ?? "Success. Reset email sent successfully. Check your email."), buttonStack: [AlertX.Button.default(Text("OK"), action: {
                                self.presentationMode.wrappedValue.dismiss()
                          })],
     
                                   theme: AlertX.Theme.custom(windowColor: Color("CustomBlue"),
                                                              alertTextColor: .white,
                                                             enableShadow: true,
                                                             enableRoundedCorners: true,
                                                             enableTransparency: true,
                                                              cancelButtonColor: .red,
                                                              cancelButtonTextColor: .red,
                                                              defaultButtonColor: Color("CustomBlueLighter"),
                                                              defaultButtonTextColor: .black,
                                                             roundedCornerRadius: 20),
                                   animation: .classicEffect())
                        })
    }
}

struct ForgotPasswordScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreenView()
    }
}
