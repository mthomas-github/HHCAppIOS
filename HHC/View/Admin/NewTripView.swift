//
//  NewTripView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//
import Amplify
import SwiftUI

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}

struct NewTripView: View {
    @EnvironmentObject var trip: TripStore
    @State var shouldShowImagePicker = false
    @State var shouldShowPicker = false
    @State var image: UIImage?
    @State var coverImageKey: String = ""
    @State var galleryImages: [String] = []
    @State var show = false
    @State var selected : [SelectedImages] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Trip Name", text: $trip.name)
                    TextField("Trip Description", text: $trip.description)
                    Stepper(value: $trip.maxPeople, in: 0...100) {
                        Text("There Will be \(trip.maxPeople) Seats Open")
                    }
                }
                Section(header: Text("Trip Dates")) {
                    DatePicker("Trip Start Date", selection: $trip.startDate)
                    DatePicker("Trip End Date", selection: $trip.endDate)
                    Toggle(isOn: $trip.tenative) {
                        Text("Date(s) Tenative?")
                    }
                }
                Section(header: Text("Trip Cost")) {
                    TextField("Price", value: $trip.total, formatter: NumberFormatter.currency)
                    Toggle(isOn: $trip.paymentPlan) {
                        Text("Payment Plan")
                    }
                }
                Section(header: Text("Images")) {
                    Text("Choose Header Image")
                    if let image = self.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    Button(action: didTapButton, label: {
                        let imageName = self.image == nil
                            ? "photo"
                            : "icloud.and.arrow.up"
                        Image(systemName: imageName)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    })
                    .sheet(isPresented: $shouldShowImagePicker, content: {
                        ImagePicker(image: $image)
                    })
                    Text("Choose Addtional Pictures")
                    if !self.selected.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 15) {
                                ForEach(selected, id: \.self) { i in
                                    Image(uiImage: i.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .cornerRadius(12)
                                } //: LOOP
                            } //: HSTACK
                        } //: SCROLL
                    }
                    Button(action: {
                        self.selected.removeAll()
                        self.show.toggle()
                    }, label: {
                        let imageIcon = self.selected == []
                            ? "photo"
                            : "icloud.and.arrow.up"
                        Image(systemName: imageIcon)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    })
                    .sheet(isPresented: $show, content: {
                        CustomPicker(selected: self.$selected, show: self.$show)
                    })
                }
                
            }
        }
        .navigationTitle("New Trip")
    }
    
    func didTapButton() {
        if let image = self.image {
            //upload image
            upload(image)
        } else {
            shouldShowImagePicker.toggle()
        }
    }
    
    
    
    
    func upload(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let key = UUID().uuidString + ".jpg"
        
        _ = Amplify.Storage.uploadData(key: key, data: imageData) { result in
            switch result {
            case .success:
                print("uploaded image")
                coverImageKey = key
                self.image = nil
                
            case .failure(let error):
                print("Failed to upload - \(error)")
            }
            
        }
    }
    
    func save() {
        //print(text)
        //        let trip = Trip(body: text)
        //        Amplify.DataStore.save(trip) { result in
        //            switch result {
        //            case .success:
        //                print("saved trip")
        //            case .failure(let error):
        //                print(error)
        //            }
        //
        //        }
        //        presentationMode.wrappedValue.dismiss()
        
    }
}
struct NewTripView_Previews: PreviewProvider {
    static let trip = TripStore()
    static var previews: some View {
        NewTripView().environmentObject(trip)
    }
}
