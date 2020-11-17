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
    @StateObject private var tripStore = TripStore()
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Adventures")
                }
            NewTripView()
                .tabItem {
                    Image(systemName: "key.icloud")
                    Text("Admin")
                }
                .environmentObject(tripStore)
        }//: TABVIEW
    }
}

struct ContentView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    
    static var previews: some View {
        ContentView(user: DummyUser())
    }
}
