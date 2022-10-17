//
//  LogRegInputs.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI

struct LogRegInputs: View {
    @Binding var input: String
    var keyboardType: UIKeyboardType
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading){
            if input.isEmpty{
                Text(placeholder)
                    .padding(.all, 20)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                    .foregroundColor(.white).opacity(0.5)
                    .padding(.bottom, -50)
            }
            TextField("", text: $input)
                .padding(.all, 20)
                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                .foregroundColor(.white)
                .padding(.bottom, -50)
        }//ZStack

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

struct LogRegInputs_Previews: PreviewProvider {
    static var previews: some View {
        LogRegInputs(input: .constant(""), keyboardType: .emailAddress, placeholder: "")
    }
}
