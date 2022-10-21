//
//  OnboardingRegisterScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/09.
//

///make all components for better layout
import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

struct OnboardingRegisterScreenView: View {
    @State var userIsLoggedIn: Bool = false
    @StateObject var authManager = AuthManager()
    var device = UIDevice.current.name
    @State var offset: CGFloat = 0
    
    //pop screen for navigation instead of stacking nav on eachother
    @Environment(\.presentationMode) var presentationMode
    
    //Image data
    @State private var showSheet: Bool = false
    @State private var showImagePicker:Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    
    //text input
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var age: Int = 0
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    private var genderArray = ["","Male", "Female", "Other"]
    @State private var selectedIndex = 0
    @State private var AllFields: Int = 0
    
    
    var body: some View {
        //Custom Pager View
        if userIsLoggedIn{
            DashboardScreenView()
        }else{
            content
        }
    }//Body
    
    var content: some View{
        ZStack{
            LinearGradient(colors: [Color("CustomBlue"), Color("CustomBlueLight")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            OffsetPageTabView(offset: $offset){
                HStack(spacing: 0){
                    ForEach(boardingReg){screen in
                        VStack{
                        }//Vstack
                        .frame(width: getScreenBounds().width)
                        .frame(maxHeight: .infinity)
                        .background(Image(screen.background)
                            .resizable()
                            .overlay(
                                Color("CustomBlue").opacity(0.4))
                            .ignoresSafeArea())
                        
                    }//foreach
                }//HStack
            }//offsettab
            .ignoresSafeArea()
            
            VStack{
                if getIndex() == 0{
                    
                    ZStack{
                        if image != nil{
                            Image("RegisterImgOnePick")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: getScreenBounds().width - 100)
                                .allowsHitTesting(false)
                        }else{
                            Image("RegisterImgOne")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: getScreenBounds().width - 100)
                                .allowsHitTesting(false)
                        }//check if image is not nil
                        
                        if device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini"{
                            if image != nil{
                                Image(uiImage: image ?? UIImage(named: "RegisterImgOne")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: getScreenBounds().width - 200)
                                    .allowsHitTesting(false)
                                    .mask(
                                        Image("PfpTemplate")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: getScreenBounds().width - 200)
                                            .allowsHitTesting(false)
                                    )
                                    .offset(x:getScreenBounds().width/29, y:getScreenBounds().height/27)
                            }//Check if there is an image
                            Image("RingPfp")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: getScreenBounds().width - 100)
                                .allowsHitTesting(false)
                        }else{
                            if image != nil{
                                Image(uiImage: image ?? UIImage(named: "RegisterImgOne")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: getScreenBounds().width - 100)
                                    .allowsHitTesting(false)
                                    .mask(
                                        Image("PfpTemplate")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: getScreenBounds().width - 100)
                                            .allowsHitTesting(false)
                                    )
                                    .offset(x:getScreenBounds().width/21, y:getScreenBounds().height/21)
                            }//Check if there is an image
                            Image("RingPfp")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: getScreenBounds().width - 100)
                                .allowsHitTesting(false)
                        }//responisveness
                   }//ZStack
                    Button(action: {
                        showSheet = true
                    }, label: {
                        ZStack{
                        Circle()
                            .fill(Color("CustomBlueLight").shadow(.drop(color: Color("CustomBlue"), radius: 5)))
                            .frame(width: getScreenBounds().width/9)
                        Image(systemName: "pencil")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .fontWeight(.bold)
                        }//ZStack
                    })
                    .offset(x:getScreenBounds().width/5, y:-getScreenBounds().height/15)
                    
                    
                    Button(action: {
                        authManager.GoogleLogin()
                    }, label: {
                        Text("Google")
                    })
                    
                    Text("Register")
                    .foregroundColor(.white)
                    .font(Font.custom("Aladin-regular", size: getScreenBounds().width/9))
                    .underline()
                    .allowsHitTesting(false)
                    
                    //Page One Form Inputs
                    
                    Spacer()
                    
                    LogRegInputs(input: $name, keyboardType: .default, placeholder: "Name")
                    LogRegInputs(input: $surname, keyboardType: .default, placeholder: "Surname")

                HStack{
                    VStack{
                        Menu {
                            Picker(selection: $age, label: EmptyView()) {
                                ForEach(0..<100) {
                                    Text("\($0)")
                                }//Foreach
                            }//Picker
                            } label: {
                                HStack {
                                    if age == 0{
                                        Text("Age")
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                    }else{
                                        Text(String(age))
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
                            .padding(.all, 20)
                            .padding(.top,-12)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                            .foregroundColor(.white)
                            .padding(.bottom, -50)
                    
                        if age == 0{
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
                                    
                                Text("Age")
                                    .padding(.all, 20)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                    .foregroundColor(.white.opacity(0.5))
                                    .padding(.horizontal, -20)
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color("CustomBlueLight"))
                                    .frame(height: 5)
                                    .padding(.trailing)
                            }//HStack
                        }//Custom Input Line
                    }//Vstack
                    VStack{
                        Menu {
                            Picker(selection: $selectedIndex, label: EmptyView()) {
                                ForEach(1 ..< genderArray.count , id: \.self) {
                                    Text(self.genderArray[$0])
                                }//Foreach
                            }//Picker
                            } label: {
                                HStack {
                                    if genderArray[selectedIndex] == ""{
                                        Text("Gender")
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                    }else{
                                        Text(String(genderArray[selectedIndex]))
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
                            .padding(.all, 20)
                            .padding(.top,-12)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                            .foregroundColor(.white)
                            .padding(.bottom, -50)
                    
                        if genderArray[selectedIndex] == ""{
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
                                    
                                Text("Gender")
                                    .padding(.all, 20)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/29))
                                    .foregroundColor(.white.opacity(0.5))
                                    .padding(.horizontal, -20)
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color("CustomBlueLight"))
                                    .frame(height: 5)
                                    .padding(.trailing)
                            }//HStack
                        }//Custom Input Line
                        
                        
                    }//Vstack
                }//Hstack
                
                    VStack{


                    Button(action:{
                        offset = min(offset + getScreenBounds().width,getScreenBounds().width * 1)
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 60)
                                .padding(.horizontal)
                                .padding(.top, 20)
                            Text("Next")
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                .padding(.top, 20)
                        }//ZStack
                    })
                        HStack{
                            Text("Already have an account?")
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/23))
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Login here")
                                    .foregroundColor(.white)
                                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/23))
                            })
                        }//Hstack
                        .padding(.top, 5)
                        .padding(.bottom, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 10 : 0 )
                    }//VStack
                    
                    

                }else{
                    
                    Image("RegisterImgTwo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: getScreenBounds().width - 100)
                        .allowsHitTesting(false)
                    
                    Text("Register")
                    .foregroundColor(.white)
                    .font(Font.custom("Aladin-regular", size: getScreenBounds().width/9))
                    .underline()
                    .padding(.top, 50)
                    .allowsHitTesting(false)
                    
                    //Page Two Form Inputs
                    
                    Spacer()
                    
                    
                    LogRegInputs(input: $username, keyboardType: .default, placeholder: "Username")
                    LogRegInputs(input: $email, keyboardType: .emailAddress, placeholder: "Email")
                    LogRegInputs(input: $password, keyboardType: .default, placeholder: "Password").padding(.top, -5)
                    
                   
                
                    VStack{
                        if AllFields == 1{
                            Text("Fill in all the fields!")
                                .foregroundColor(.yellow)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }else{
                            Text("\(authManager.message)")
                                .foregroundColor(.yellow)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                            
                        }

                    Button(action:{
                        if (name.isEmpty || surname.isEmpty || age == 0 && genderArray[selectedIndex] == "" || username.isEmpty || email.isEmpty || password.isEmpty || image == nil){
                            AllFields = 1
                            
                        }else{
                            AllFields = 0
                            authManager.registerUser(email: email, password: password, name: name, surname: surname, age: age, gender: genderArray[selectedIndex], username: username)
                        }
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 60)
                                .padding(.horizontal)
                                .padding(.top, 20)
                            Text("Register")
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                .padding(.top, 20)
                        }//ZStack
                    })
                        
                        HStack{
                            Text("Already have an account?")
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/23))
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Login here")
                                    .foregroundColor(.white)
                                    .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/23))
                            })
                        }//Hstack
                        .padding(.top, 5)
                        .padding(.bottom, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 10 : 0 )
                    }//VStack
                }//if else for getindex
            }//VStack
        }//ZStack
        .onAppear{
            Auth.auth().addStateDidChangeListener{auth, user in
                if user != nil {
                    withAnimation{
                        userIsLoggedIn.toggle()
                    }//animation
                }//if user is not nil
            }//listening state
        }//on appear
        .actionSheet(isPresented: $showSheet){
            ActionSheet(title: Text("Select between"), message: Text(""), buttons: [.default(Text("Photo Library")){
                self.showImagePicker = true
                self.sourceType = .photoLibrary
            },
            .default(Text("Camera")){
                self.showImagePicker = true
                self.sourceType = .camera
            },
                .cancel()
            ])
        }//actionsheet to choose between library or camera
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: $image, isShown: $showImagePicker, sourceType: self.sourceType)
        }//sheet for library or camera
    }
    

    
    //getIndex of pages
    func getIndex()->Int{
            let progress = (offset / getScreenBounds().width).rounded()

            return Int(progress)
        }
}//end View



struct OnboardingRegisterScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingRegisterScreenView()
    }
}

//extending View to get screen bounds
extension View{
    func getScreenBounds()->CGRect{
        return UIScreen.main.bounds
    }
    

    
}
