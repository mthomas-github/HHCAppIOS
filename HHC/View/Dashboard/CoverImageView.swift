//
//  CoverImageView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//
import Amplify
import SwiftUI

struct CoverImageView: View {
    // MARK: - PROPERTIES
    let trips: [Trip]
    @State var imageCache = [String: UIImage?]()
    // MARK: - BODY
    var body: some View {
        TabView{
            ForEach(Array(imageCache.values), id: \.self) { image in
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }//: LOOP
        }//: TAB
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            downloadImages(for: trips)
        }
    }
    
    func downloadImages(for trips: [Trip]) {
        for trip in trips {
            _ = Amplify.Storage.downloadData(key: trip.coverImageKey) { result in
                switch result {
                case .success(let imageData):
                    let image = UIImage(data: imageData)
                    imageCache[trip.coverImageKey] = image
                    DispatchQueue.main.async {
                        imageCache[trip.coverImageKey] = image
                    }
                case .failure(let error):
                    print("Failed to download image data - \(error)")
                }
            }
        }
    }
}

struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView(trips: [])
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
