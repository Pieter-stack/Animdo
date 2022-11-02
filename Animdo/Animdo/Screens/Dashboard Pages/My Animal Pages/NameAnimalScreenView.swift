//
//  NameAnimalScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI
import AlertX
import SDWebImageSwiftUI

struct NameAnimalScreenView: View {
    @ObservedObject private var vm = AllAnimalsViewModel()
    var animal : AllAnimals 
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var showAlert = false
    @State private var errString: String = ""
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                Text("Name your \(animal.species)")
                .foregroundColor(.black)
                .font(Font.custom("Aladin-regular", size: getScreenBounds().width/9))
                .underline()
                .padding(.bottom,getScreenBounds().width/100 )
                .padding(.top, 40)
                Spacer()
                
                ZStack{
                    WebImage(url:URL(string: animal.animalImage))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getScreenBounds().width - 50, height: getScreenBounds().height/4.5)
                        .cornerRadius(12)
                        .blur(radius: 5)
                        .opacity(0.5)
                    WebImage(url:URL(string: animal.animalImage))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10.0)
                        .frame(width: getScreenBounds().width - 50, height: getScreenBounds().height/4.5)
                        .opacity(0.9)
                }.padding(.top, -10)
                
                Text("Give your newly adopted \(animal.species) a name, to make \(animal.gender == "Male" ? "him" : "her" ) stand out!")
                    .foregroundColor(.black)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                    .padding(.bottom, 150)
                    .padding(.top, 30)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .lineSpacing(1.2)

                ZStack(alignment: .leading){
                    if name.isEmpty{
                        Text(" Adoptee Name")
                            .padding(.all, 20)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                            .foregroundColor(.black).opacity(0.5)
                            .padding(.bottom, -50)
                    }
                    TextField("", text: $name)
                        .padding(.all, 20)
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                        .foregroundColor(.black)
                        .padding(.bottom, -50)
                }//ZStack

                if name.isEmpty{
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
                            
                        Text("Adoptee Name")
                            .padding(.all, 20)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                            .foregroundColor(.black.opacity(0.5))
                            .padding(.horizontal, -20)
                        
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("CustomBlueLight"))
                            .frame(height: 5)
                            .padding(.trailing)
                    }//HStack
                }//Custom Input Line
                
                if errString == ""{
                    
                }else{
                    Text("Please give a name to your adoptee")
                        .foregroundColor(.red)
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                Button(action:{
                    if name.isEmpty{
                        errString = "Error"
                    }else{
                        vm.renameAnimal(animaluid: animal.uid, animalName: name)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color("CustomBlueLight"))
                            .frame(height: 60)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        Text("Name your adoptee")
                            .foregroundColor(.white)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                            .padding(.top, 20)
                    }//ZStack
                })
                .padding(.bottom, 30)
            }//VStack
        }//ZStack
        .onAppear(){
            self.vm.fetchAllAnimals()
            
        }//onappear
    }
}

struct NameAnimalScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NameAnimalScreenView(animal: AllAnimals(uid: "1", name: "", tagCode: "123456", species: "Shark", longitude: "1.10", latitude: "2.20", gender: "Male", age: 10, animalImage: "https://firebasestorage.googleapis.com:443/v0/b/animdo.appspot.com/o/animals%2FD5D5A4D1-1238-432D-ACA0-B22A32386FAB.jpg?alt=media&token=c8cf4ff6-ab58-413a-92a0-2363c919ac73", country: "South Africa", isoCode: "ZA", ocean: "atlantic", adopted: true, adoper: "1111", tokens: "1"))
    }
}
