//
//  SettingsScreenView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/25.
//

import SwiftUI
import FirebaseAuth

struct SettingsScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("loggedIn") var loggedIn: Bool = true
    @AppStorage("Userloaded") var userLoaded: Bool = true
    @State var userIsLoggedIn: Bool = true
    var body: some View {
        
        if userIsLoggedIn{
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
                        .padding(.leading, 20)
                        Spacer()
                            Button(action: {
                                try? Auth.auth().signOut()
                                loggedIn = false
                                userLoaded = true
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color("CustomDark"))
                                        .frame(width: 150, height: 40)
                                        .padding(.trailing, -40)
                                        .clipped()
                                    Text("Logout")
                                        .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/25))
                                        .foregroundColor(Color("White"))
                                }//ZStack
                            })

                    }//HStack
                    HStack{

                    VStack(alignment: .leading){
                            Text("Want to learn,")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                .foregroundColor(Color("CustomBeige"))
                            Text("More?")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/12))
                                .foregroundColor(.black)
                    }//VStack
                      Spacer()
                    }//HStack
                    .padding(.leading, 40)
                    .padding(.top, 30)
                    Image("SettingsPic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: getScreenBounds().width - 180)
                        .padding(.top)
                    HStack{

                    VStack(alignment: .leading){
                            Text("About Animdo")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                .foregroundColor(Color("CustomBeige"))
                        Text("Animdo is a non-profit application designed to help endangered animals from around the globe. Animdo needs your help to track and take care of these animals from poachers. By adopting an animal you are directly contributing to the non-profit organizations to take care of these animals.")
                            .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/29))
                            .foregroundColor(Color("Black"))
                            .padding(.top, 1)
                    }//VStack
                      Spacer()
                    }//HStack
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.top, 10)
                    HStack{

                    VStack(alignment: .leading){
                            Text("Terms of Service")
                                .font(Font.custom("JosefinSans-SemiBold", size: getScreenBounds().width/14))
                                .foregroundColor(Color("CustomBeige"))
                        ScrollView{
                            Text("1. Agreement to Terms By viewing or using this Website, which can be accessed at Animdo or through our mobile application Animdo, you are agreeing to be bound by all these Website’s Terms of Use and agree with any applicable local laws. If you disagree with any of these terms, you are prohibited from accessing this Website or using the Service. All materials in this Website are protected by trade mark law and copyright.For purposes of this Terms of Use, the terms “company”, “we” and “our” refers to the Company.2. Privacy policy We advise you to read our privacy policy  regarding our user data collection. It will help you better understand our practices.3. Use License Permission is granted to temporarily download one copy of the materials on our Website for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not: modify or copy the materials;use the materials for any commercial purpose or for any public display;attempt to reverse engineer any software contained on our Website;remove any copyright or other proprietary notations from the materials; ortransferring the materials to another person or 'mirror' the materials on any other server. This will let Company to terminate upon violations of any of these restrictions. Upon termination, your viewing right will also be terminated and you should destroy any downloaded materials in your possession whether it is electronic format or printed.4. DisclaimermAll the materials on our Website are provided on an “as is” basis.  You agree that your use of the Website will be at your own risk. We make no warranties, may it be expressed or implied, therefore negates all other warranties. Furthermore, Company does not make any representations concerning the accuracy or reliability of the use of the materials on its Website or otherwise relating to such materials or any sites linked to this Website.5. Limitations Company or its suppliers will not be hold accountable for any damages that will arise with the use or inability to use the materials on our Website, even if we or an authorised representative of this Website has been notified, orally or written, of the possibility of such damage. Some jurisdiction does not allow limitations on implied warranties or limitations of liability for incidental damages, these limitations may not apply to you.6. Corrections There may be information or materials appearing on our Website that contains technical, typographical, or photographic errors. We will not promise that any of the materials in this Website are accurate, complete, or current. We reserve the right to change and update the materials contained on its Website at any time without prior notice. 7. Links Company ****has no control over all links provided on this Website and is not responsible for the contents of any such linked site. The presence of any link does not imply endorsement of the site by Open Window. The use of any linked website is at your own risk. 8. Modification of Terms of Use Company may revise or include supplemental terms in these Terms of Use on its Website from time to time without prior notice. Please ensure that you check the current Terms of Use every time you use the Website. By using this Website, you are agreeing to be bound by the current version of these Terms of Use. 9. Applicable law Any claim related to our Website shall be governed by the laws of South Africa without regards to its conflict of law provisions.10. Contact")
                                .font(Font.custom("JosefinSans-Regular", size: getScreenBounds().width/29))
                                .foregroundColor(Color("Black"))
                                .padding(.top, 1)
                        }
                        .padding(.bottom, 35)
                    }//VStack
                      Spacer()
                    }//HStack
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.top, 10)
                    
                    
                    Spacer()
                    Text("Developed by Pieter Venter")
                        .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/29))
                        .foregroundColor(Color("Black"))
                    Text("Version")
                        .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/29))
                        .foregroundColor(Color("Black"))
                    Text("1.0")
                        .font(Font.custom("JosefinSans-Bold", size: getScreenBounds().width/29))
                        .foregroundColor(Color("Black"))
                    
                }//VStack
            }//ZStack
            .onAppear{
                Auth.auth().addStateDidChangeListener{auth, user in
                    if user == nil {
                        withAnimation{
                            userIsLoggedIn = false
                        }
                    }
                }
            }//on appear
        }else{
           LoginScreenView()
        }
        
        
        
        
    }
}



struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreenView()
    }
}
