//
//  ContentView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//
import Amplify
import SwiftUI

struct ContentView: View {
    let user: AuthUser
    let groupName: String
    @ObservedObject var sessionManager = SessionManager()
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Adventures")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("My Profile")
                }
            if(groupName == "Admin") {
            AdminView()
                .tabItem {
                    Image(systemName: "key.icloud")
                    Text("Admin")
                }
            }
        }//: TABVIEW
    }
}

struct ContentView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    
    static var previews: some View {
        ContentView(user: DummyUser(), groupName: "Admin")
    }
}
