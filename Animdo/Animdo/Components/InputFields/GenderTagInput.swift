//
//  GenderTagInput.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/19.
//

import SwiftUI

struct GenderTagInput: View {
    var genderArray = ["","Male", "Female"]
    @Binding var input: Int
    var placeholder: String
    var body: some View {
        VStack(alignment: .leading){
            Text(placeholder)
                .foregroundColor(.black)
                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                .padding(.horizontal, 10)
                .padding(.top, -20)
            ZStack{
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("CustomBlueLight"))
                    .frame(height: 50)
                    .padding(.trailing)
                    ZStack(alignment: .leading){
                        Menu {
                            Picker(selection: $input, label: EmptyView()) {
                                ForEach(1 ..< genderArray.count , id: \.self) {
                                    Text(self.genderArray[$0])
                                }//Foreach
                            }//Picker
                            } label: {
                                HStack {
                                    if genderArray[input] == ""{
                                        Text(placeholder)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                    }else{
                                        Text(String(genderArray[input]))
                                    }
                                    Spacer()
                                    Text("⌵")
                                        .offset(y: -4)
                                }
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                .padding()
                                .frame(height: 32)
                                .cornerRadius(16)
                            }//Menu
                            .padding(.all)
                    }//ZStack
            }//Zstack
            .padding(.top, -5)
        }//VStack
    }
}

struct GenderTagInput_Previews: PreviewProvider {
    static var previews: some View {
        GenderTagInput(input: .constant(0), placeholder: "")
    }
}
