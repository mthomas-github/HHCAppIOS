//
//  CoverImageView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct CoverImageView: View {
    // MARK: - PROPERTIES
    let trips: [Trip]
    // MARK: - BODY
    var body: some View {
        TabView{
            ForEach(trips) { item in
                Image(item.coverImage)
                    .resizable()
                    .scaledToFill()
            }//: LOOP
        }//: TAB
        .tabViewStyle(PageTabViewStyle())
    }
}

struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView(trips: [])
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
