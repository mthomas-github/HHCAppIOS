//
//  SettingView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var sessionManager = SessionManager()
    
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    @AppStorage("isDeleting") var isDeleting: Bool = false
    @AppStorage("isVerifying") var isVerifying: Bool = false
    @AppStorage("email") var email = ""
    //@State var manager = LoginManager()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    //MARK: - SECTION 1
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "Hertiage Hiking Club", labelImage: "info.circle")
                    ) {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                            Image("HHC_4inBug")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            Text("Hiking (Urban hiking too) is fun and is a great physical workout, but walking is also an awesome way to immerse yourself in nature for some soul-care; and a super easy micro-adventure that you can have any day of the week, to escape the grind and refresh the heck out of yourself for what lies ahead in life. ")
                                .font(.footnote)
                        }
                    }
                    
                    //MARK: - SECTION 2
                    GroupBox(
                        label: SettingsLabelView(labelText: "User Info", labelImage: "person.icloud.fill")
                    ) {
                        Divider().padding(.vertical, 4)
                        SettingsRowView(name: "Email", content: "mthomas2270@gmail.com")
                        SettingsRowView(name: "First Name", content: "Michael Thomas")
                        SettingsRowView(name: "Last Name", content: "Michael Thomas")
                    }
                    
                    //MARK: - SECTION 3
                    GroupBox(
                        label: SettingsLabelView(labelText: "App Settings", labelImage: "paintbrush")
                    ) {
                        Divider().padding(.vertical, 4)
                        Toggle(isOn: $isDeleting) {
                            Text("Delete Account".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                        Divider().padding(.vertical, 4)
                        if isVerifying {
                            SettingsRowView(name: "FB Verification", content: "Verfied")
                            } else {
                                //FacebookButtonView()
                            }
                    }
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    )
                    //MARK: - SECTION 4
                    GroupBox(
                        label: SettingsLabelView(labelText: "Application Info", labelImage: "apps.iphone")
                    ) {
                        
                        SettingsRowView(name: "Developer", content: "Michael Thomas")
                        SettingsRowView(name: "Version", content: appVersionString)
                        Button("Sign Out", action: {
                            sessionManager.signOut()
                        })
                    }
                }//: VSTACK
                .navigationBarTitle(Text("Settings"), displayMode: .large)
                .padding()
            }//: SCROLL
        } //: NAVAGATION
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
