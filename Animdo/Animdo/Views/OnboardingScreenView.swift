//
//  OnboardingScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/08.
//

import SwiftUI

struct OnboardingScreenView: View {
    
//Data Models
    @State var boardingScreens: [Onboarding] = [
        Onboarding(title: "Location Tracking", description: "To protect the animals, Animdo will not share live locations for their safety. Only YOU will be able to know exactly where your animal was tagged for the first time.", picture: "OnboardingImgOne", background: "OnboardingBGOne"),
        Onboarding(title: "Adopt a wild Animal", description: "By adopting one of these animals: Elephant, Lion, Polar Bear, Penguin, Shark, Sea Turtle you help save them. All of the funds goes to non profit organizations.", picture: "OnboardingImgTwo", background: "OnboardingBGTwo"),
        Onboarding(title: "Name your animal", description: "When adopting an animal to be rescued you will then have access to give them a name and also see more details about your animal, you will also be able to donate more to help your little friend out!", picture: "OnboardingImgThree", background: "OnboardingBGThree")
        ]
    

    
    //Gesture Properties
    @GestureState var isDragging: Bool = false
    var device = UIDevice.current.name
    @State var fakeIndex: Int = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
            ZStack{
                ForEach(boardingScreens.indices.reversed(), id: \.self) { index in
                    //onboard view
                    IntroView(onboard: boardingScreens[index])
                    //Custom Liquid shape
                        .clipShape(LiquidShape(offset: boardingScreens[index].offset, curvePoint: fakeIndex == index ? 50 : 0))
                    
                        .ignoresSafeArea()
                    
                    
                }//Foreach
                HStack(spacing: 8){
                    if currentIndex == 2{
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    
                    
                    //INDICATORS
                    ForEach(0..<boardingScreens.count - 2, id: \.self){index in
                        Image(currentIndex == index ? "PawPrintOne" : "PawPrintTwo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .scaleEffect(currentIndex == index ? 1.15 : 0.85)
                            .opacity(currentIndex == index ? 1 : 0.85)
                    }
                    if currentIndex == 2{
                        
                        
                        Spacer()
                        ZStack{
                            Rectangle()
                                .frame(width: 100, height: 50)
                                .foregroundColor(Color("CustomBrownLight"))
                                .padding(.trailing, 30)
                                .cornerRadius(30)
                                .padding(.trailing, -30)
                            NavigationLink(destination: DashboardScreenView().navigationBarBackButtonHidden(true)){
                                Text("Done")
                                    .foregroundColor(.black)
                                    .font(Font.custom("Aladin-regular", size: 32))
                                
                            }//Navigation Link
 
                        }//ZStack
                        
                    }//foreach
                }//HStack
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom,  device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 10 : 0 )
            }//Zstack
            .overlay(
                Button(action:{
                    
                }, label:{
                    Image(systemName: "chevron.right")
                        .font(.largeTitle)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .contentShape(Rectangle())
                        .gesture(
                            
                            DragGesture()
                                .updating($isDragging, body: { value, out, _ in
                                    out = true
                                })//Updating
                                .onChanged({value in
                                    //updating offset
                                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                        
                                        boardingScreens[fakeIndex].offset = value.translation
                                    }
                                    
                                })//onchange
                                .onEnded({value in
                                    withAnimation(.spring()){
                                        //checking
                                        if -boardingScreens[fakeIndex].offset.width > getRect().width / 2{
                                            
                                            //setting width to height
                                            boardingScreens[fakeIndex].offset.width = -getRect().height * 1.5
                                            
                                            //Updating Index
                                            fakeIndex += 1
                                            
                                            //updating orignal index
                                            if currentIndex == boardingScreens.count - 3{
                                                currentIndex = 0
                                            }else{
                                                currentIndex += 1
                                            }
                                            
                                            //delay to finish swipe animation
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                                                if fakeIndex == (boardingScreens.count - 2){
                                                    for index in 0..<boardingScreens.count - 2{
                                                        boardingScreens[index].offset = .zero
                                                    }
                                                    
                                                    fakeIndex = 0
                                                }
                                            }
                                            
                                            
                                        }else{
                                            boardingScreens[fakeIndex].offset = .zero
                                        }
                                    }
                                })//on ended
                        )
                })
                
                .offset(x: 3, y: device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 90 : 50)
                .opacity(isDragging ? 0 : 1)
                .animation(.linear, value: isDragging)
                ,alignment: .topTrailing
            )
            .onAppear{
                //Inserting last element to first when onboarding process complete
                //and first to last to create a feel like infinite carousel
                
                guard let first = boardingScreens.first else {
                    return
                }
                
                guard var last = boardingScreens.last else {
                    return
                }
                
                last.offset.width = -getRect().height * 1.5
                
                boardingScreens.append(first)
                boardingScreens.insert(last, at: 0)
                
                //updating fake index
                fakeIndex = 1
            }
        .navigationBarBackButtonHidden(true)
    }//Body
    
    //View builder
    @ViewBuilder
    func IntroView(onboard: Onboarding)-> some View{
        GeometryReader{metrics in
            VStack{
                
                Image(onboard.picture)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: metrics.size.width/1.2)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(onboard.title)
                        .foregroundColor(.white)
                        .font(Font.custom("Aladin-regular", size: metrics.size.width/9))
                    Text(onboard.description)
                        .foregroundColor(.white)
                        .font(Font.custom("Roboto-Light", size: metrics.size.width/20))
                        .padding(.top)
                        .frame(width: getRect().width - 100)
                        .lineSpacing(3)
                    
                }//Vstack
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding([.trailing, .top])
                
            }//Vstack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(onboard.background)
                    .resizable()
                    .ignoresSafeArea()
            )
            
        }//GeoReader
    }
    
}//End

//Extending View to get screen bounds

extension View{
    func getRect()-> CGRect{
        return UIScreen.main.bounds
    }
}

struct LiquidShape: Shape{
    
    var offset: CGSize
    var curvePoint: CGFloat
    
    // Multiple AnimatingTable data
    
    
    
    //Animating Shapes
    var animatableData: AnimatablePair<CGSize.AnimatableData, CGFloat>{
        get{
            return AnimatablePair(offset.animatableData, curvePoint)
        }
        set{
            offset.animatableData = newValue.first
            curvePoint = newValue.second
        }
    }
    
    
    func path(in rect: CGRect) -> Path{
        return Path{path in
            
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            
            //Constructing shape
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            //constucting curve shape
            
            //form
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to
            
            //mid between 80n - 180
            let mid: CGFloat = 80 + ((to - 80) / 2)
          
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - curvePoint, y: mid), control2: CGPoint(x: width - curvePoint, y: mid))
            
        }//Path
    }//path func
}//Liquid shape


    
    struct OnboardingScreenView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingScreenView()
        }
    }
    

