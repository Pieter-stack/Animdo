//
//  TagScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/16.
//

import SwiftUI
import CoreML
import Vision


struct TagScreenView: View {
    @StateObject var tagManager = TagManager()
    //Device sizes
    var device = UIDevice.current.name
    //Image data
    @State private var showSheet: Bool = false
    @State private var showImagePicker:Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    //inputs
    @State private var tagCode: String = ""
    @State private var species: String = ""
    @State private var longitude: String = ""
    @State private var latitude: String = ""
    private var genderArray = ["","Male", "Female"]
    @State private var selectedIndex = 0
    @State private var age: Int = 0
    @State private var showAlert = false
    //Animal Recognition AI
    private let classifier = try! VisionClassifier(mlModel: CustomAnimdoClassifier(configuration: MLModelConfiguration()).model)
    //Location Manager
    @StateObject var locationManager = LocationManager()
    @ObservedObject var lm = SpesificLocationManager()
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                Text("Tag an")
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                    .foregroundColor(Color("CustomBeige"))
                Text("Animal")
                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                    .foregroundColor(.black)
                    Spacer()
            }//HStack
                .padding(.leading, 30)
                Spacer()
                Spacer()
            }
            VStack{

                if image == nil{
                  RoundedRectangle(cornerRadius: 12)
                        .fill(Color("CustomBeigeLight"))
                        .frame(width: getScreenBounds().width - 50, height: getScreenBounds().height/4.5)
                        .padding(.top, 70)
                       
                }else{
                    
                    ZStack{
                        Image(uiImage: image ?? UIImage(named: "Test")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getScreenBounds().width - 50, height: getScreenBounds().height/4.5)
                            .cornerRadius(12)
                            .blur(radius: 5)
                            .opacity(0.5)
                        Image(uiImage: image ?? UIImage(named: "Test")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10.0)
                            .frame(width: getScreenBounds().width - 50, height: getScreenBounds().height/4.5)
                            .opacity(0.9)
                            
                    }.padding(.top, 70)
                }
                

             
                Button(action: {
                    showSheet = true
                }, label: {
                    ZStack{
                        Circle()
                            .strokeBorder(Color("CustomBeige"),lineWidth: 4)
                            .frame(width: getScreenBounds().width/6, height: getScreenBounds().height/6)
                        Circle()
                            .fill(Color("CustomBeige"))
                            .frame(width: getScreenBounds().width/7.5, height: getScreenBounds().height/7.5)
                        Image(systemName: "camera.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: getScreenBounds().width/14, height: getScreenBounds().height/14)
                            .foregroundColor(Color.white)
                            
                        
                    }//ZStack
                })
                .padding(.top, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? -55 :-80)
                .padding(.bottom, -40)
                
                if device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini"{
                    ScrollView{
                        VStack(alignment: .leading){
                            Text("Scan Tag")
                                .foregroundColor(.black)
                                .foregroundColor(.black)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                .padding(.horizontal, 30)
                                
                            ZStack{
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color("CustomBlueLight"))
                                    .frame(height: 60)
                                    .padding(.horizontal)
                                HStack{
                                    ZStack(alignment: .leading){
                                        if tagCode.isEmpty{
                                            Text("Scan Tag Code")
                                                .padding(.all, 20)
                                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                                .foregroundColor(.white).opacity(0.5)
                                                .padding(.leading, 20)
                                                .padding(.bottom, -5)
                                        }
                                        TextField("", text: $tagCode)
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }//ZStack
                                    Button(action: {
                                        
                                    }, label: {
                                        ZStack{
                                            Circle()
                                                .strokeBorder(Color("BG"),lineWidth: 4)
                                                .background(Circle().foregroundColor(Color.white))
                                                .frame(width: getScreenBounds().width/7, height: getScreenBounds().height/7)
                                                .padding(.trailing)
                                            Image("TagScan")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: getScreenBounds().width/15, height: getScreenBounds().height/15)
                                                .padding(.trailing)
                                        }
                                    })
                                }//HSTack
                            }//Zstack
                            .padding(.top, -15)
                        }//VStack
                        
                        VStack(alignment: .leading){
                            Text("Species")
                                .foregroundColor(.black)
                                .foregroundColor(.black)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                .padding(.horizontal, 30)
                                .padding(.top, -20)
                            ZStack{
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color("CustomBlueLight"))
                                    .frame(height: 60)
                                    .padding(.horizontal)
                                HStack{
                                    ZStack(alignment: .leading){
                                        if species.isEmpty{
                                            Text("Analyse species")
                                                .padding(.all, 20)
                                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                                .foregroundColor(.white).opacity(0.5)
                                                .padding(.leading, 20)
                                                .padding(.bottom, -5)
                                        }
                                        TextField("", text: $species)
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }//ZStack
                                    Button(action: {
                                     
                                        
                                        if let img = self.image{
                                            self.classifier?.classify(img){result in
                                                self.species = result
                                            }
                                        }
                                        
                                    }, label: {
                                        ZStack{
                                            Circle()
                                                .strokeBorder(Color("BG"),lineWidth: 4)
                                                .background(Circle().foregroundColor(Color.white))
                                                .frame(width: getScreenBounds().width/7, height: getScreenBounds().height/7)
                                                .padding(.trailing)
                                            Image("SpeciesScan")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: getScreenBounds().width/15, height: getScreenBounds().height/15)
                                                .padding(.trailing)
                                        }
                                    })
                                        
                                }//HSTack
                            }//Zstack
                            .padding(.top, -30)
                        }//VStack
                       
                        VStack(alignment: .leading){
                            Text("Location")
                                .foregroundColor(.black)
                                .foregroundColor(.black)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                .padding(.horizontal, 30)
                                .padding(.top, -20)
                            ZStack{
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color("CustomBlueLight"))
                                    .frame(height: 60)
                                    .padding(.horizontal)
                                HStack{
                                    ZStack(alignment: .leading){
                                        if longitude.isEmpty{
                                            Text("Long:")
                                                .padding(.all, 20)
                                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                                .foregroundColor(.white).opacity(0.5)
                                                .padding(.leading, 20)
                                                .padding(.bottom, -5)
                                        }
                                        TextField("", text: $longitude)
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }//ZStack
                                    ZStack(alignment: .leading){
                                        if latitude.isEmpty{
                                            Text("Lat:")
                                                .padding(.all, 20)
                                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                                .foregroundColor(.white).opacity(0.5)
                                                .padding(.leading, 20)
                                                .padding(.bottom, -5)
                                        }
                                        TextField("", text: $latitude)
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }//ZStack
                                    Button(action: {
                                        
                                        longitude = userLongitude
                                        latitude = userLatitude
                                        
                                   

                                    }, label: {
                                        ZStack{
                                            Circle()
                                                .strokeBorder(Color("BG"),lineWidth: 4)
                                                .background(Circle().foregroundColor(Color.white))
                                                .frame(width: getScreenBounds().width/7, height: getScreenBounds().height/7)
                                                .padding(.trailing)
                                            Image("LocationScan")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: getScreenBounds().width/15, height: getScreenBounds().height/15)
                                                .padding(.trailing)
                                        }
                                    })
                                
                                }//HSTack
                            }//Zstack
                            .padding(.top, -30)
                        }//VStack
                        
                        
                        HStack{

                            AgeTagInput(input: $age, placeholder: "Age")
                            GenderTagInput(input: $selectedIndex, placeholder: "Gender")
                            
                        }//HStack

                        Spacer()

                        Button(action:{

                            
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color("CustomBlueLight"))
                                    .frame(height: 60)
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                                Text("Tag")
                                    .foregroundColor(.white)
                                    .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                    .padding(.top, 20)
                            }//ZStack
                        })
                        .padding(.bottom, 100)

                       
                      Spacer()
                        
                    }//Scrollview
                    .frame(height: 400)
                    .padding(.top, 40)
                    
                }else{
                    VStack(alignment: .leading){
                        Text("Scan Tag")
                            .foregroundColor(.black)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                            .padding(.horizontal, 30)
                            
                        ZStack{
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 50)
                                .padding(.horizontal)
                            HStack{
                                ZStack(alignment: .leading){
                                    if tagCode.isEmpty{
                                        Text("Scan Tag Code")
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }
                                    TextField("", text: $tagCode)
                                        .padding(.all, 20)
                                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                        .foregroundColor(.white)
                                        .padding(.leading, 20)
                                        .padding(.bottom, -5)
                                }//ZStack
  
                                

                                    ZStack{
                                        Circle()
                                            .strokeBorder(Color("BG"),lineWidth: 4)
                                            .background(Circle().foregroundColor(Color.white))
                                            .frame(width: getScreenBounds().width/7, height: getScreenBounds().height/7)
                                            .padding(.trailing)
                                        ScanTag(text: $tagCode)
                                            .frame(width: getScreenBounds().width/15, height: getScreenBounds().height/15)
                                            .padding(.trailing)
                                          
                                    }
                                    
                                

                                    
                            }//HSTack
                        }//Zstack
                        .padding(.top, -40)
                    }//VStack
                    
                    VStack(alignment: .leading){
                        Text("Species")
                            .foregroundColor(.black)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                            .padding(.horizontal, 30)
                            .padding(.top, -40)
                        ZStack{
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 50)
                                .padding(.horizontal)
                            HStack{
                                ZStack(alignment: .leading){
                                    if species.isEmpty{
                                        Text("Analyse species")
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }
                                    TextField("", text: $species)
                                        .padding(.all, 20)
                                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                        .foregroundColor(.white)
                                        .padding(.leading, 20)
                                        .padding(.bottom, -5)
                                }//ZStack
                                Button(action: {
                                    ///HERE
                                    //self.performImageClasification()
                                    
                                    if let img = self.image{
                                        self.classifier?.classify(img){result in
                                            self.species = result
                                        }
                                    }
                                }, label: {
                                    ZStack{
                                        Circle()
                                            .strokeBorder(Color("BG"),lineWidth: 4)
                                            .background(Circle().foregroundColor(Color.white))
                                            .frame(width: getScreenBounds().width/7, height: getScreenBounds().height/7)
                                            .padding(.trailing)
                                        Image("SpeciesScan")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: getScreenBounds().width/15, height: getScreenBounds().height/15)
                                            .padding(.trailing)
                                    }
                                })


                                    
                            }//HSTack
                        }//Zstack
                        .padding(.top, -60)
                    }//VStack
                   
                    VStack(alignment: .leading){
                        Text("Location")
                            .foregroundColor(.black)
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                            .padding(.horizontal, 30)
                            .padding(.top, -40)
                        ZStack{
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 50)
                                .padding(.horizontal)
                            HStack{
                                ZStack(alignment: .leading){
                                    if longitude.isEmpty{
                                        Text("Long:")
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }
                                    TextField("", text: $longitude)
                                        .padding(.all, 20)
                                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                        .foregroundColor(.white)
                                        .padding(.leading, 20)
                                        .padding(.bottom, -5)
                                }//ZStack
                                ZStack(alignment: .leading){
                                    if latitude.isEmpty{
                                        Text("Lat:")
                                            .padding(.all, 20)
                                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                            .foregroundColor(.white).opacity(0.5)
                                            .padding(.leading, 20)
                                            .padding(.bottom, -5)
                                    }
                                    TextField("", text: $latitude)
                                        .padding(.all, 20)
                                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                        .foregroundColor(.white)
                                        .padding(.leading, 20)
                                        .padding(.bottom, -5)
                                }//ZStack
                                Button(action: {
                                    longitude = userLongitude
                                    latitude = userLatitude
                                }, label: {
                                    ZStack{
                                        Circle()
                                            .strokeBorder(Color("BG"),lineWidth: 4)
                                            .background(Circle().foregroundColor(Color.white))
                                            .frame(width: getScreenBounds().width/7, height: getScreenBounds().height/7)
                                            .padding(.trailing)
                                        Image("LocationScan")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: getScreenBounds().width/15, height: getScreenBounds().height/15)
                                            .padding(.trailing)
                                    }
                                })
                                

                                    
                            }//HSTack
                        }//Zstack
                        .padding(.top, -60)
                    }//VStack
                    
                    
                    HStack{
                        AgeTagInput(input: $age, placeholder: "Age")
                        GenderTagInput(input: $selectedIndex, placeholder: "Gender")
                       
                    }//HStack
                    .padding(.top, -15)

                    Button(action:{


                        
                        if (tagCode.isEmpty || species.isEmpty || age == 0 && genderArray[selectedIndex] == "" || longitude.isEmpty || latitude.isEmpty  || image == nil){
                            showAlert = true
                            
                        }else{
                            showAlert = false
                            
                            lm.get(longitude: Double(longitude)!, latitude: Double(latitude)!)

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                tagManager.TagNewAnimal(tagCode: tagCode, species: species, longitude: longitude, latitude: latitude, gender: genderArray[selectedIndex], age: age, animalImage: image!, country: lm.Country ?? "", isoCode: lm.isoCode ?? "", ocean: lm.Ocean ?? "")
                                tagCode = ""
                                species = ""
                                longitude = ""
                                latitude = ""
                                selectedIndex = 0
                                age = 0
                                image = nil
                            }

                        }
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color("CustomBlueLight"))
                                .frame(height: 60)
                                .padding(.horizontal)
                                .padding(.top, 20)
                            Text("Tag")
                                .foregroundColor(.white)
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/20))
                                .padding(.top, 20)
                        }//ZStack
                    })
                    .padding(.top, -5)

                   
                  Spacer()
                }
            }//vStack
            
        }//ZStack
        .alert(isPresented: $showAlert){
            Alert(title: Text("Oops something went wrong!"), message: Text(tagManager.message == "" ? "Please fill in all the fields" : tagManager.message), dismissButton: .default(Text("OK")){
            })
        }
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
        .fullScreenCover(isPresented: $showImagePicker){
            ImagePicker(image: $image, isShown: $showImagePicker, sourceType: self.sourceType)
        }//sheet for library or camera
    }//body
    
}//tagscreen

struct TagScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TagScreenView()
    }
}

