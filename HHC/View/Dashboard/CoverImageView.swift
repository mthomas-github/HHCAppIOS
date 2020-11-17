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
    @State var imageCache: [UIImage] = []
    // MARK: - BODY
    var body: some View {
        if imageCache.isEmpty {
            Text("Loading...")
                .onAppear {
                    downloadImages(for: trips)
                }
        }
        else {
            TabView {
                ForEach(imageCache, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
    
    func downloadImages(for trips: [Trip]) {
        for trip in trips {
            Amplify.Storage.downloadData(key: trip.coverImageKey) { result in
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

struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView(trips: [])
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
