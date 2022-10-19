//
//  AgeTagInput.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/19.
//

import SwiftUI

struct AgeTagInput: View {
    @Binding var input: Int
    var placeholder: String
    var body: some View {
        VStack(alignment: .leading){
            Text(placeholder)
                .foregroundColor(.black)
                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                .padding(.horizontal, 30)
                .padding(.top, -20)
            ZStack{
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("CustomBlueLight"))
                    .frame(height: 50)
                    .padding(.leading)
                    ZStack(alignment: .leading){
                        Menu {
                            Picker(selection: $input, label: EmptyView()) {
                                ForEach(0..<100) {
                                    Text("\($0)")
                                }//Foreach
                            }//Picker
                            } label: {
                                HStack {
                                    if input == 0{
                                        Text(placeholder)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                    }else{
                                        Text(String(input))
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
struct AgeTagInput_Previews: PreviewProvider {
    static var previews: some View {
        AgeTagInput(input: .constant(0), placeholder: "")
    }
}
