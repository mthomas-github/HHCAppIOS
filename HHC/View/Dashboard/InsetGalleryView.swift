//
//  InsetGalleryView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct InsetGalleryView: View {
    let trip: Trip

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(trip.gallery!, id: \.self) { item in
                    Image(item)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                } //: LOOP
            } //: HSTACK
        } //: SCROLL
    }
}

struct InsetGalleryView_Previews: PreviewProvider {
    static let trips: [Trip] = []
    
    static var previews: some View {
        InsetGalleryView(trip: trips[0])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
