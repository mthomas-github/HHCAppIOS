//
//  TripListItemView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct TripListItemView: View {
    let trip : Trip
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(trip.coverImage)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            VStack(alignment: .center, spacing: 8) {
                Text(trip.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
                
                Text(trip.description)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)
            }//: VStack
        } //: HSTACK
    }
}

struct TripListItemView_Previews: PreviewProvider {
    static let trips : [Trip] = []
    static var previews: some View {
        TripListItemView(trip: trips[0])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
