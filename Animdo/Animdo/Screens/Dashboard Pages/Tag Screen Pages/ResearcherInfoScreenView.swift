//
//  ResearcherInfoScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI

struct ResearcherInfoScreenView: View {
    
    @State var steps = ["Step 1", "Step 2"," Step 3", "Step 4", "Step 5", "Step 6"]
    
    init(){
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                Text("The Penguin's Guide")
                .foregroundColor(.black)
                .font(Font.custom("Aladin-regular", size: getScreenBounds().width/9))
                .underline()
                .padding(.bottom,getScreenBounds().width/100 )
                .padding(.top, 40)
                
                TabView{
                    ForEach(steps, id: \.self){step in
                      Image("LoginBG")
                          
                    }
                }//Tabview
                .tabViewStyle(PageTabViewStyle())
                .ignoresSafeArea()
            }//VStack
        }//ZStack
    }
}

struct ResearcherInfoScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ResearcherInfoScreenView()
    }
}
