//
//  AdminTripView.swift
//  HHC
//
//  Created by Michael Thomas on 11/18/20.
//

import SwiftUI

struct AdminTripView: View {
    var body: some View {
            List {
                ScrollView(.vertical, showsIndicators: false) {
                    NavigationLink(destination: AdminNewTripView()) {
                    AdminBadgeView(imageName: "map-marker-plus", imageSize: 50, isLocked: false, title: "Add", description: "Add New Trip")
                    }
                    .disabled(false)
                    NavigationLink(destination: AdminTripListView()) {
                    AdminBadgeView(imageName: "map-marker-alt", imageSize: 50, isLocked: false, title: "Mange", description: "Manage Existing Trips")
                    }
                    .disabled(false)
                    NavigationLink(destination: Text("Test")) {
                    AdminBadgeView(imageName: "file-invoice-dollar", imageSize: 50, isLocked: true, title: "Payment", description: "Manage Trip Payments")
                    }
                    .disabled(false)
                }
            } //: LIST
            .navigationBarTitle("Trip Options")
    }
}

struct AdminTripView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTripView()
    }
}
