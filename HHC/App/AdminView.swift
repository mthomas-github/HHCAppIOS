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
        List {
            ScrollView(.vertical, showsIndicators: false) {
                AdminBadgeView(imageName: "map-marker-alt", imageSize: 50, isLocked: false, title: "Trip", description: "Manage Trips", buttonAction: {print("Three")})
                AdminBadgeView(imageName: "users", imageSize: 40, isLocked: false, title: "Members", description: "Manage Members", buttonAction: {print("Four")})
                AdminBadgeView(imageName: "clipboard-user", imageSize: 50, isLocked: false, title: "Staff Members", description: "Manage Staff Members", buttonAction: {print("Five")})
                AdminBadgeView(imageName: "cogs", imageSize: 40, isLocked: true, title: "App Settings", description: "Global App Settings", buttonAction: {print("Five")})
            }
        }
    }
}




struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
