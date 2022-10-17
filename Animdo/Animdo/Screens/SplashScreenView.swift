//
//  SplashScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/08.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.7
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    var body: some View {
        
        if isActive{
            if isOnboarding{
                OnboardingScreenView()
            }else{
                LoginScreenView()
            }
            
        }else{
            GeometryReader{metrics in
                ZStack{
                    Image("SplashPageBG")
                        .resizable()
                        .ignoresSafeArea()
                    VStack{
                        Image("Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: metrics.size.width/3)
                        Text("Animdo")
                            .foregroundColor(.white)
                            .font(Font.custom("Aladin-regular", size: metrics.size.width/6))
                            .padding(.top, -10)
                    }//VStack
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 1
                            self.opacity = 1
                        }
                    }
                }//ZStack
            }//GeoReader
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            
        }
        

        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
