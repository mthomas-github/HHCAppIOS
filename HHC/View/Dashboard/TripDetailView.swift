//
//  TripDetailView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
            // IMAGE
                Image(trip.coverImageKey)
                    .resizable()
                    .scaledToFit()
            // TITLE
                Text(trip.name.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .foregroundColor(.primary)
            // HEADLINE
                Text(trip.description)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal)
            // GALLERY
                Group {
                    HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Extra Pictures")
                    InsetGalleryView(trip: trip)
                }
                .padding(.horizontal)
            // DESCRIPTION
            } // : VSTACK
            .navigationBarTitle("Learn about \(trip.name)",
                                displayMode: .inline)
        } //: SCROLL
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static let trips: [Trip] = []
       
    static var previews: some View {
        NavigationView {
            TripDetailView(trip: trips[0])
        }
        .previewDevice("iPhone 11 Pro")
    }
}
