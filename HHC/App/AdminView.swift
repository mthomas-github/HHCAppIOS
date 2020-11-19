//
//  AdminView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import Amplify
import Combine
import SwiftUI

struct AdminView: View {
    var body: some View {
        NavigationView {
            List {
                ScrollView(.vertical, showsIndicators: false) {
                    NavigationLink(destination: AdminTripView()) {
                    AdminBadgeView(imageName: "map-marker-alt", imageSize: 50, isLocked: false, title: "Trip", description: "Manage Trips")
                    }
                    .disabled(false)
                    NavigationLink(destination: AdminMemberListView()) {
                    AdminBadgeView(imageName: "users", imageSize: 40, isLocked: true, title: "Members", description: "Manage Members")
                    }
                    .disabled(true)
                    NavigationLink(destination: AdminStaffListView()) {
                    AdminBadgeView(imageName: "clipboard-user", imageSize: 50, isLocked: true, title: "Staff Members", description: "Manage Staff Members")
                    }
                    .disabled(true)
                    NavigationLink(destination: AppGlobalSettingsView()) {
                    AdminBadgeView(imageName: "cogs", imageSize: 40, isLocked: true, title: "App Settings", description: "Global App Settings")
                    }
                    .disabled(true)
                }
            } //: LIST
            .navigationBarTitle("Admin")
        }
    }
}




struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
