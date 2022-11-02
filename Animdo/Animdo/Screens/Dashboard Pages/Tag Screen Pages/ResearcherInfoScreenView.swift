//
//  ResearcherInfoScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI

struct ResearcherInfoScreenView: View {
    
    @State var steps = ["Start", "Scan", "Analyse", "LongLat", "AgeGender", "TagAnimal"]
    @AppStorage("ShowGuide") var ShowGuide: Bool = true
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
                .padding(.top, 20)
                
                TabView{
                    ForEach(steps, id: \.self){step in
                            Image(step)
                    }//Foreach
                }//Tabview
                .tabViewStyle(PageTabViewStyle())
                .ignoresSafeArea()
            }//VStack
        }//ZStack
        .onAppear{
            ShowGuide = false
        }
    }
}

struct ResearcherInfoScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ResearcherInfoScreenView()
    }
}
