//
//  TripListItemView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//
import Amplify
import SwiftUI

struct TripListItemView: View {
    let trip : Trip
    @State var imageData: UIImage? = nil
    
    var body: some View {
        if imageData != nil {
            HStack(alignment: .center, spacing: 16) {
                Image(uiImage: imageData ?? UIImage.init())
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
        } else {
            Text("Loading Trip: \(trip.name)")
                .onAppear{
                    downloadImage(trip: trip)
                }
        }
    }
    
    func downloadImage(trip: Trip) {
        Amplify.Storage.downloadData(key: trip.coverImageKey) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    return
                }
                self.imageData = image
                
            case .failure(let error):
                print("Failed to download image data - \(error)")
            }
        }
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
