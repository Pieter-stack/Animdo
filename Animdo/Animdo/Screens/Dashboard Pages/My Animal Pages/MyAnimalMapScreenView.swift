//
//  MyAnimalMapScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct Location: Identifiable{
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MyAnimalMapScreenView: View {
    
    @StateObject var locationManager = LocationManager()
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
     @State var distance: String = ""
    
    @ObservedObject private var vm = AllAnimalsViewModel()
    var device = UIDevice.current.name
    @Environment(\.presentationMode) var presentationMode
    var animal : AllAnimals
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2) )
    
    var Locations = [
        Location(coordinate: CLLocationCoordinate2D(latitude: 37.785834, longitude:-122.406417))
    ]
    
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
                    .padding(.top, device == "iPod touch (7th generation)" || device == "iPhone SE (3rd generation)" || device == "iPhone 8" || device == "iPhone 8 Plus" || device == "iPhone 13 mini" ? 0 : 20)
                    .padding(.leading, 20)
                    Spacer()
                }//HStack
                HStack{
                        Text("Where is,")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/13))
                            .foregroundColor(Color("CustomBeige"))
                        Text("\(animal.name)?")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/12))
                            .foregroundColor(.black)
                    Spacer()
                }//HStack
                .padding(.leading, 30)
                .padding(.top, 20)
                    Map(coordinateRegion: $mapRegion, annotationItems: Locations){location in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(animal.latitude)!, longitude: Double(animal.longitude)!) , content: {
                            CustomPin(color: animal.species == "Lion" || animal.species == "Elephant" ? "CustomBrownLight" : animal.species == "Polar Bear" || animal.species == "Penguin" || animal.species == "Shark" ? "CustomBlueLighter" : animal.species == "Sea Turtle" ? "CustomGreenLighter" : "CustomGreenLighter", image: animal.species == "Lion" ? "LionIcon" : animal.species == "Elephant" ? "ElephantIcon" : animal.species == "Lion" ? "LionIcon" : animal.species == "Polar Bear" ? "PolarBearIcon" : animal.species == "Penguin" ? "PenguinIcon" :  animal.species == "Shark" ? "SharkIcon" : animal.species == "Sea Turtle" ? "SeaTurtleIcon" : "")
                            
                        })
                        
                    }
                    .frame(width: getScreenBounds().width - 50, height: getScreenBounds().width)
                    .cornerRadius(30)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: getScreenBounds().width - 50, height: 220)
                        .padding(.top, 20)
                    HStack{
                        ZStack{
                            WebImage(url:URL(string: animal.animalImage))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getScreenBounds().width / 3, height: getScreenBounds().height / 5)
                                .cornerRadius(12)
                                .blur(radius: 5)
                                .opacity(0.5)
                            WebImage(url:URL(string: animal.animalImage))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10.0)
                                .frame(width: getScreenBounds().width / 3, height: getScreenBounds().height / 5)
                                .opacity(0.9)
                                
                        }.padding(.top, 30)

                        VStack(alignment: .leading){
                            Text("\(animal.name), the \(animal.species)")
                                .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/22))
                                .foregroundColor(Color("Black"))
                                .padding(.top, 15)
                            HStack{
                               Image(systemName: "mappin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 4)
                                    .padding(.trailing, 5)
                                    .foregroundColor(.black)
                                if animal.country == ""{
                                    Text("\(animal.ocean)")
                                        .padding(.top, 2)
                                        .padding(.leading, -8)
                                        .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/35))
                                        .foregroundColor(.black)
                                }else{
                                    Text("\(animal.country), \(animal.isoCode)")
                                        .padding(.top, 2)
                                        .padding(.leading, -8)
                                        .font(Font.custom("JosefinSans-Light", size: getScreenBounds().width/35))
                                        .foregroundColor(.black)
                                }
                                Spacer()
                            }//Hstack
                                .padding(.bottom, 50)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 90)
                                    .fill(Color("CustomDark"))
                                    .frame(width: 200, height: 50)
                                    .padding(.trailing, -22)
                                    .clipped()
                                HStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color(animal.species == "Lion" || animal.species == "Elephant" ? "CustomBrownLight" : animal.species == "Polar Bear" || animal.species == "Penguin" || animal.species == "Shark" ? "CustomBlueLighter" : animal.species == "Sea Turtle" ? "CustomGreenLighter" : "CustomGreenLighter"))
                                            .frame(width: 50)
                                        Image(animal.species == "Lion" ? "LionIcon" : animal.species == "Elephant" ? "ElephantIcon" : animal.species == "Lion" ? "LionIcon" : animal.species == "Polar Bear" ? "PolarBearIcon" : animal.species == "Penguin" ? "PenguinIcon" :  animal.species == "Shark" ? "SharkIcon" : animal.species == "Sea Turtle" ? "SeaTurtleIcon" : "")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25)
                                    }//ZStack
                                    .padding(.leading, 20)
                                    VStack(alignment: .leading){
                                        Text("My animal Friend")
                                            .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/35))
                                            .foregroundColor(Color("White"))
                                        Text("\(distance) km away")
                                            .font(Font.custom("JosefinSans-regular", size: getScreenBounds().width/42))
                                            .foregroundColor(Color("White"))
                                            .padding(.top, 2)
                                    }//VStack
                                    Spacer()
                                }//HStack
                                
                            }//ZStack
                            .padding(.trailing, -35)
                            
                            

                            
                            
                            
                        }//VStack
                        .padding(.leading, 15)
                    }//HStack
                    .padding(.horizontal, 39)
                    
                }//ZStack

                    
                
                
                Spacer()
                
            }//VStack
            }//ZStack
        .onAppear(){
            self.vm.fetchAllAnimals()
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(animal.latitude)!, longitude: Double(animal.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2) )
            MKMapView.appearance().mapType = .satellite
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let coordinate0 = CLLocation(latitude: Double(animal.latitude)!, longitude: Double(animal.longitude)!)
            let coordinate1 = CLLocation(latitude: Double(userLatitude)!, longitude: Double(userLongitude)!)

             let distancemeters = coordinate0.distance(from: coordinate1)
            let distanceKm = distancemeters / 1000
                distance = String(format: "%.2f", distanceKm)
            
                print("user long\(userLongitude)")
                print("user lat\(userLatitude)")
                print("animal long\(animal.longitude)")
                print("animal lat\(animal.latitude)")
            }
        }//onappear


    }
}

struct MyAnimalMapScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyAnimalMapScreenView(animal: AllAnimals(uid: "1", name: "Alex",  tagCode: "123456", species: "Shark", longitude: "-122.406417", latitude: "37.785834", gender: "Male", age: 10, animalImage: "https://firebasestorage.googleapis.com:443/v0/b/animdo.appspot.com/o/animals%2FD5D5A4D1-1238-432D-ACA0-B22A32386FAB.jpg?alt=media&token=c8cf4ff6-ab58-413a-92a0-2363c919ac73", country: "South Africa", isoCode: "ZA", ocean: "atlantic", adopted: true, adoper: "1111", tokens: "1"))
    }
}
