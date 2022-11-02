//
//  DashboardScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/08.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct DashboardScreenView: View {
    @State var userIsLoggedIn: Bool = true
    @AppStorage("loggedIn") var loggedIn: Bool = true
    @AppStorage("Userloaded") var userLoaded: Bool = true
    @ObservedObject private var vm = SignedInUser()
    

    var body: some View {
        if loggedIn{
            TabViewScreen()
        }else{
           LoginScreenView()
        }

                
        

    }
    
    
    //will become settings
    var content: some View{
        VStack{
            Text("\(Auth.auth().currentUser?.uid ?? "")")
            Button(action: {
                try? Auth.auth().signOut()
            }, label: {
                Text("Logout")
            })
        }
        .onAppear{
            Auth.auth().addStateDidChangeListener{auth, user in
                if user == nil {
                    withAnimation{
                        userIsLoggedIn.toggle()
                    }//animation
                }//if user is nil and logged out
            }//listening state
        }//onappear
    }
}

struct DashboardScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreenView()
    }
}


struct TabViewScreen: View{
    @State var selectedtab = "Home"
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    //Location for each Curve
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    @ObservedObject private var vm = SignedInUser()



    var body: some View{
        let device = UIDevice.current.name
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedtab){
              
               
                AdoptionPurchaseFailScreenView()
                        .tag("Adoption")
                    
                    HomeScreenView()
                        .tag("Home")
                    
                    MyAnimalsScreenView()
                        .tag("My Animals")
                
                if vm.user?.role == "User"{
                    UserSideTagScreenView()
                        .tag("Tag")
                    
                }else{
                    TagScreenView()
                        .tag("Tag")
                }
                    
                   
                
                

            }//TabView
            

            
            //Custom Tab Bar
            HStack(spacing:0){
                
                ForEach( tabs, id:\.self){ image in
                    GeometryReader { metrics in
                        Button(action: {
                          withAnimation(.spring()){
                              selectedtab = image
                              xAxis = metrics.frame(in: .global).minX
                          }
                      }, label: {
                          if device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini"{
                              VStack{
                                  Image(image)
                                      .resizable()
                                      .aspectRatio(contentMode: .fit)
                                      .frame(width:25, height:25)
                                      .padding(selectedtab == image ? 15 : 0)
                                      .background(Color("Tab")
                                    .opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                      .matchedGeometryEffect(id: image, in: animation)
                                      .offset(x: selectedtab == image ? (metrics.frame(in: .global).minX - metrics.frame(in: .global).midX) : 0 ,y: selectedtab == image ? -50 : 0)
                                  Text(image)
                                      .font(Font.custom("Aladin-regular", size: getScreenBounds().width/40))
                                      .frame(width: 50)
                                      .foregroundColor(Color("CustomBeige"))
                                      .offset(x: selectedtab == image ? (metrics.frame(in: .global).minX - metrics.frame(in: .global).midX) : 0 ,y: selectedtab == image ? -30 : 0)
                              }

                           
                          }else{
                              VStack{
                                  Image(image)
                                      .resizable()
                                      .aspectRatio(contentMode: .fit)
                                      .frame(width:25, height:25)
                                      .padding(selectedtab == image ? 15 : 0)
                                      .matchedGeometryEffect(id: image, in: animation)
                                      .offset(x: selectedtab == image ? (metrics.frame(in: .global).minX - metrics.frame(in: .global).midX) : 0 ,y: selectedtab == image ? -30 : 0)
                                  Text(image)
                                      .font(Font.custom("Aladin-regular", size: getScreenBounds().width/40))
                                      .frame(width: 50)
                                      .foregroundColor(Color("CustomBeige"))
                                      .offset(x: selectedtab == image ? (metrics.frame(in: .global).minX - metrics.frame(in: .global).midX) : 0 ,y: selectedtab == image ? -30 : 0)
                              }

                           
                          }//if statement
                               })
                                     .onAppear(perform: {
                                         var tab: Int = 1

                                             if selectedtab == "Adoption"{
                                                tab = 0
                                             }else if selectedtab == "Home"{
                                                 tab = 1
                                             }else if selectedtab == "My Animals"{
                                                 tab = 2
                                             }else if selectedtab == "Tag"{
                                                 tab = 3
                                        
                                         }
                                         

                                         
                                         if image == tabs[tab]{
                                             xAxis = metrics.frame(in: .global).minX
                                         }
                                     })
 
                    }//ZStack
                    .frame(width:25, height:45)
                  
                    
                    if image != tabs.last{Spacer(minLength: 0)}
                    
                }//Foreach
            }//HStack
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color("Tab")
                .clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
            .padding(.bottom, UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }?.safeAreaInsets.bottom)
          
        }//ZStack
        .ignoresSafeArea(.all,edges: .bottom)
        .padding(.bottom, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 0 : -50)
    }//body
    
    
    
    
}//Home



var tabs = ["Adoption", "Home", "My Animals", "Tag"]




//Curve for tabbar

struct CustomShape: Shape{
    
    var xAxis: CGFloat
    
    //Animating Path
    var animatableData: CGFloat{
        get { return xAxis}
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path{
        return Path{ path in
           
            path.move(to: CGPoint(x: 0 ,y: 0))
            path.addLine(to: CGPoint(x: rect.width ,y: 0))
            path.addLine(to: CGPoint(x: rect.width ,y: rect.height))
            path.addLine(to: CGPoint(x: 0 ,y: rect.height))
            
            let center = xAxis
            
            path.move(to:CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
            
        }//Path
    }//Func
}//CustomShape



