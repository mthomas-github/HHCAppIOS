//
//  InsetGalleryView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//
import Amplify
import SwiftUI

struct InsetGalleryView: View {
    let trip: Trip
    @State var imageCache: [UIImage] = []
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(imageCache, id: \.self) { item in
                    Image(uiImage: item)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                } //: LOOP
            } //: HSTACK
        } //: SCROLL
        .onAppear {
            downloadGallaryImages(for: trip.gallery!)
        }
    }
    
    func downloadGallaryImages(for trips: [String]) {
        for trip in trips {
            Amplify.Storage.downloadData(key: trip) { result in
                switch result {
                case .success(let imageData):
                    guard let image = UIImage(data: imageData) else {
                        return
                    }
                    DispatchQueue.main.async {
                        imageCache.append(image)
                    }
                case .failure(let error):
                    print("Failed to download image data - \(error)")
                }
            }
        }
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
