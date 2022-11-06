//
//  DashboardDetailScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/25.
//

import SwiftUI

struct DashboardDetailScreenView: View {
    var animal : DashboardAnimals = dashAnimals[0]
    @Environment(\.presentationMode) var presentationMode
    @State var filterSearch: String = "ALL"

    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                             .font(.title)
                             .fontWeight(.black)
                    })
                    .padding(.leading, 20)
                    Spacer()
                }//HStack
                Text(animal.animal)
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/12))
                    .foregroundColor(Color("Black"))
                    .padding(.top, -35)
                
                HStack(spacing: 25){
                    VStack{
                     Text("Lifespan")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/20))
                            .foregroundColor(.black)
                        Text(animal.lifespan)
                            .padding(.top, 5)
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/29))
                            .foregroundColor(.black)
                    }//VStack
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color("Black"))
                        .frame(width: 2, height: 70)
                    VStack{
                        Text("Location")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/20))
                            .foregroundColor(.black)
                        Text(animal.location)
                            .padding(.top, 5)
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/29))
                            .foregroundColor(.black)
                    }//VStack
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color("Black"))
                        .frame(width: 2, height: 70)
                    VStack{
                        Text("Quantity")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/20))
                            .foregroundColor(.black)
                        Text(animal.Quantity)
                            .padding(.top, 5)
                            .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/29))
                            .foregroundColor(.black)
                    }//VStack
                }//HStack
                .padding(.top, 30)
                
                ZStack{
                   Circle()
                        .fill(Color(animal.animal == "Polar Bear" || animal.animal == "Shark" || animal.animal == "Penguin" ? animal.secondaryColor : animal.primaryColor))
                        .frame(width: getScreenBounds().width/1.2)
                        

                    VStack{
                        Image(animal.image)
                            .padding(.top, -40)
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(animal.animal == "Polar Bear" || animal.animal == "Shark" || animal.animal == "Penguin" ? animal.primaryColor : animal.secondaryColor))
                                .frame(width: getScreenBounds().width - 70, height: 100)
                           Text("Awaiting Adoption")
                                .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/17))
                                .foregroundColor(.white)
                        }//ZStack
                    }//VStack
                }//ZStack
                .padding(.top, 70)
                ScrollView{
                    Text(animal.description)
                        .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                }
                .padding(.top)
                .padding(.horizontal, 30)
                
                Spacer()
                
                
                
                NavigationLink(destination: AdoptionDetailPurchaseScreenView(filterSearch: .constant(animal.animal)).navigationBarBackButtonHidden(true)){
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("CustomDark"))
                            .frame(width: getScreenBounds().width - 150, height: 60)
                        Text("Adopt Me!")
                            .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/17))
                            .foregroundColor(.white)
                            .padding(.top, 5)
                        
                    }//ZStack
                }
                Spacer()
                
            }//VStack
        }//ZStack
    }
}

struct DashboardDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardDetailScreenView(animal: dashAnimals[0])
    }
}
