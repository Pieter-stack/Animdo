//
//  UserSideTagScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/11/01.
//

import SwiftUI

struct UserSideTagScreenView: View {
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Want to learn more about,")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                            .foregroundColor(Color("CustomBeige"))
                        Text("Researchers?")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/11))
                            .foregroundColor(.black)
                    }//VStack
                    Spacer()
                }//HStack
                .padding(.leading, 30)
                Image("ResearcherIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: getScreenBounds().width / 2)
                    .padding(.top, 30)
                HStack{
                    VStack(alignment: .leading){
                        Text("About the Researchers")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                            .foregroundColor(Color("CustomBeige"))
                            .padding(.top, 30)
                        ScrollView{
                            Text("By affixing tracking tags to animals, researchers can virtually dive, hunt, and migrate with wildlife they could never otherwise follow, and collect invaluable data. The tags are giving scientists insight into life and death mysteries, including possible causes of the population’s decline. To find out where ocean animals go and the routes they take to get there, scientists attach electronic tags to them. Those tags collect data on temperature, depth, and location, then transmit their data via satellite. Tagging animals help keep data of what could be causing the decline in population and how weare able to save them from extinction.")
                                .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/29))
                                .foregroundColor(Color("Black"))
                                .padding(.top, 1)
                        }
                        .padding(.bottom, 35)
                        .frame(height: 125)
                        
                        Text("About the animals")
                            .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/15))
                            .foregroundColor(Color("CustomBeige"))
                        ScrollView{
                            Text("Tagging is used to obtain different information. Habitat use and migration patterns are one of the main reasons. You cannot protect an animal unless you know how it uses it’s habitat. For marine animals it can give amazing insight into dive patterns and hunting behaviour that would remain a complete mystery otherwise, they even have the capacity to give you information on the tilt of the animal in the water column! Tags can give detailed information on home range size and core habitat characteristic. Home range is the area in which the animal spends it’s time and core range is the area within the home range it utilises intensively. Capturing an animal to tag it also gives scientists the opportunity to take blood samples that they would never otherwise get which is very useful as, for example, you can find out more about the gene pool and how different populations are or are not interbreeding.")
                                .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/29))
                                .foregroundColor(Color("Black"))
                                .padding(.top, 1)
                        }
                        .padding(.bottom, 35)
                        .frame(height: 156)
                    }//VStack
                    Spacer()
                }//HStack
                .padding(.leading, 30)
                
                Spacer()
            }//VStack
        }//ZStack
    }
}

struct UserSideTagScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UserSideTagScreenView()
    }
}
