//
//  PasswordInputs.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/23.
//

import SwiftUI

struct PasswordInputs: View {
    @Binding var input: String
    @Binding var visible: Bool
    var keyboardType: UIKeyboardType
    var placeholder: String
    var body: some View {
        HStack{
        ZStack(alignment: .leading){
            if input.isEmpty{
                Text(placeholder)
                    .padding(.all, 20)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                    .foregroundColor(.white).opacity(0.5)
                    .padding(.bottom, -42)
            }
            if visible{
                TextField("", text: $input)
                    .padding(.all, 20)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                    .foregroundColor(.white)
                    .padding(.bottom, -42)
            }else{
                SecureField("", text: $input)
                    .padding(.all, 20)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                    .foregroundColor(.white)
                    .padding(.bottom, -42)
            }

        }//ZStack

            Button(action: {
                visible.toggle()
            }, label: {
                if visible{
                    Image(systemName: "eye.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 35)
                        .foregroundColor(.white)
                        

                }else{
                    Image(systemName: "eye")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 35)
                        .foregroundColor(.white)
                    
                }
            })
            .padding(.all, 20)
            .padding(.bottom, -42)
    

        }
        .padding(.top, -14)

        if input.isEmpty{
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
                    
                Text(placeholder)
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
    }
}

struct PasswordInputs_Previews: PreviewProvider {
    static var previews: some View {
        LogRegInputs(input: .constant(""),  keyboardType: .emailAddress, placeholder: "")
        
    }
}
