//
//  PurchaseScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/27.
//

import SwiftUI
import StoreKit

struct PurchaseScreenView: View {
    @EnvironmentObject private var store: IAPStore
    @Environment(\.presentationMode) var presentationMode
    var device = UIDevice.current.name
    var body: some View {
        ZStack{
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
                    .padding(.top, -20)
                    .padding(.top, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 0 : 50)
                    .padding(.leading, 20)
                    Spacer()
                    ZStack{
                        Image("TopCoin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
                        HStack{
                            Image("LionCoin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .padding(.top, -5)
                            let consumableCount = store.tokens.ConsumableCount
                            Text("\(consumableCount)")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/19))
                                .foregroundColor(Color("White"))
                        }//HStack
                        .padding(.top, -10)
                    }//ZStack
                    
                }//HStack
                HStack{
                    VStack(alignment: .leading){
                        Text("Animal")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                            .foregroundColor(Color("CustomBeige"))
                        Text("Rescue Center")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/13))
                            .foregroundColor(.black)
                        
                    }//VStack
                    .padding(.top, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 0 : 10)
                    Spacer()
                }//HStack
                .padding(.leading, 30)
                
                HStack{
                    
                    Text("Buy token Bundles")
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/17))
                        .foregroundColor(Color("CustomBeige"))
                    Spacer()
                }.padding(.leading, 30)
                    .padding(.top, 30)
                
                if device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini"{
                    ScrollView{
//                        TokenA.Row(purchasable: store.tokens)
//                        TokenB.Row(purchasable: store.tokens2)
//                        TokenC.Row(purchasable: store.tokens3)
                    }//Scrollview
                }else{
                                    TokenA.Row(purchasable: store.tokens)
                                    TokenB.Row(purchasable: store.tokens2)
                                    TokenC.Row(purchasable: store.tokens3)
                }
                
                

                
                Spacer()
                HStack{

                    Text("Thank you for donating")
                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/17))
                        .foregroundColor(Color("CustomBeige"))
                    Spacer()
                }.padding(.leading, 30)
                    .padding(.top, 30)



                ZStack{
                   RoundedRectangle(cornerRadius: 15)
                        .fill(Color("CustomGreenLighter"))
                        .frame(width: getScreenBounds().width - 50, height: 80)
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                 .fill(Color("CustomeGreenLight"))
                                 .aspectRatio(contentMode: .fit)
                                 .frame(width: 60)
                                 .padding(.leading, 35)
                                 .padding(.trailing, 5)

                        Image("SeaTurtleIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .padding(.leading, 35)
                                .padding(.trailing, 5)
                        }//ZStack
                        VStack(alignment: .leading){
                            HStack{
                                Text("Thanks from the Animdo Team")
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                    .foregroundColor(Color("White"))
                                Spacer()
                            }
                            Text("By donating you help save these animals from extinction")
                                .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/35))
                                .foregroundColor(Color("White"))
                                .padding(.top, 2)
                                .padding(.trailing, 25)
                                .lineSpacing(1.2)
                        }//VStack
                        Spacer()

                    }//HStack
//
                }//ZStack
                .padding(.bottom, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 30 : 100)
                
            }//Vstack
            .ignoresSafeArea()
        }//Zstack
        
    }
}

struct PurchaseScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseScreenView()
    }
}


private extension TokenA {
    struct Row <Purchasable: Animdo.Purchasable> :View {
    @EnvironmentObject private var store: IAPStore
    let purchasable: Purchasable

    var body: some View {
      
          
          Button(action: {
              Task {
                try await store.buy(purchasable)
              }
          }, label: {
              ProductRow(product: store.tokens.product) {}
          })
      
    }
  }
}

private extension TokenB {
    struct Row <Purchasable: Animdo.Purchasable> :View {
    @EnvironmentObject private var store: IAPStore
    let purchasable: Purchasable

    var body: some View {
      
          
          Button(action: {
              Task {
                try await store.buy(purchasable)
              }
          }, label: {
              ProductRow(product: store.tokens2.product) {}
          })
      
    }
  }
}

private extension TokenC {
    struct Row <Purchasable: Animdo.Purchasable> :View {
    @EnvironmentObject private var store: IAPStore
    let purchasable: Purchasable

    var body: some View {
      
          
          Button(action: {
              Task {
                try await store.buy(purchasable)
              }
          }, label: {
              ProductRow(product: store.tokens3.product) {}
          })
      
    }
  }
}


private struct ProductRow<TrailingView: View>: View {
  let product: Product
  @ViewBuilder let trailingView: () -> TrailingView

  var body: some View {
      ZStack{
          RoundedRectangle(cornerRadius: 50)
              .fill(Color("CustomDark"))
              .frame(width: getScreenBounds().width + 90, height: 100)
              .padding(.trailing, -90)
              .clipped()
              .padding(.trailing, -50)
              .padding(.top)
          
          HStack{
                 Image("LionCoin")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 60)
                      .padding(.top, 12)
              VStack(alignment: .leading){
                  HStack{
                      Text("\(product.displayName)")
                          .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/21))
                          .foregroundColor(Color("White"))
                          .padding(.leading, 5)
                          .padding(.top, 15)
                      Spacer()
                      ZStack{
                          RoundedRectangle(cornerRadius: 50)
                              .fill(Color("CustomGreenLight"))
                              .frame(width: 150, height: 25)
                              .padding(.trailing, -50)
                              .clipped()
                              .padding(.trailing, -10)
                          HStack{
                              Text("\(product.displayPrice)")
                                  .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/31))
                                  .foregroundColor(Color("White"))
                                  .padding(.top, 2)
                          }//HStack
                      }//ZStack

                  }//HStack
                  Text("Adopt your favourite animal")
                      .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/25))
                      .foregroundColor(Color("White"))
                      .padding(.leading, 5)
                      .padding(.top, 2)
                  
              }//VStack
              Spacer()
          }//HStack
          .padding(.leading, 50)
      }//ZStack
  }
}

private struct PurchaseButton<Purchasable: Animdo.Purchasable>: View {
  let purchasable: Purchasable
  @EnvironmentObject private var store: IAPStore

  var body: some View {
    Button {
      Task {
        try await store.buy(purchasable)
      }
    } label: {
      HStack {
        Image(systemName: "cart")
        Text("Buy")
      }
    }
    .buttonStyle(.plain)
    .padding(10)
    .foregroundColor(.yellow)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .stroke(Color.yellow, lineWidth: 2)
    )
  }
}
