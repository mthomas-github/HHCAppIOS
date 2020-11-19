//
//  AdminNewTripView.swift
//  HHC
//
//  Created by Michael Thomas on 11/18/20.
//

import Amplify
import SwiftUI

struct AdminNewTripView: View {
    @State var shouldShowImagePicker = false
    @State var shouldShowPicker = false
    @State var image: UIImage?
    @State var show = false
    @State var selected : [SelectedImages] = []
    @ObservedObject var tripInput = TripInput()
    let uploadImages = DispatchGroup()
    
    
    var body: some View {
        Form {
            Section(header: Text("Trip Details")) {
                TextField("Trip Name", text: $tripInput.tripName)
                TextField("Trip Description", text: $tripInput.tripDescription)
                Stepper(value: $tripInput.tripMaxSeats, in: 0...100) {
                    Text("There Will be \(tripInput.tripMaxSeats) Seats Open")
                }
            }
            Section(header: Text("Trip Dates")) {
                DatePicker("Trip Start Date", selection: $tripInput.tripStartDate)
                DatePicker("Trip End Date", selection: $tripInput.tripEndDate)
                Toggle(isOn: $tripInput.tripDatesTenative) {
                    Text("Date(s) Tenative?")
                }
            }
            Section(header: Text("Trip Cost")) {
                TextField("Price", value: $tripInput.tripTotalCost, formatter: NumberFormatter.currency)
                Toggle(isOn: $tripInput.hasPaymentPlan) {
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
                Button(action: singleImageButtonTap, label: {
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
                Button(action: mutiplyImageButtonTap, label: {
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
            Button(action: save, label: {
                Text("Save Trip")
            })
        }
        .navigationBarTitle("New Trip")
    }
    
    
    func mutiplyImageButtonTap() {
        if !self.selected.isEmpty {
            
            for select in selected {
                uploadImages.enter()
                upload(select.image)
            }
            uploadImages.notify(queue: .main) {
                selected.removeAll()
            }
        } else {
            show.toggle()
        }
    }
    
    
    func singleImageButtonTap() {
        if let image = self.image {
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
                if !self.selected.isEmpty {
                    self.tripInput.galleryImages.append(key)
                    uploadImages.leave()
                } else {
                    self.tripInput.coverImageKey = key
                    self.image = nil
                }
                
            case .failure(let error):
                print("Failed to upload - \(error)")
            }
            
        }
    }
    
    func save() {
        
        let convertST = Temporal.DateTime(self.tripInput.tripStartDate)
        let convertET = Temporal.DateTime(self.tripInput.tripEndDate)
        let newTrip = Trip(name: self.tripInput.tripName, description: self.tripInput.tripDescription, total: self.tripInput.tripTotalCost, coverImageKey: self.tripInput.coverImageKey, tripPhase: Phase(rawValue: Phase.new.rawValue), startDate: convertST, endDate: convertET, tenative: self.tripInput.tripDatesTenative, gallery: self.tripInput.galleryImages, members: [""], maxSeats: self.tripInput.tripMaxSeats, paymentPlan: self.tripInput.hasPaymentPlan)
        
        
        Amplify.DataStore.save(newTrip) { result in
            switch result {
            case .success:
                print("success")
                self.tripInput.clear()
            case .failure(let error):
                print("there was an error: \(error)")
            }
        }
    }
}

struct AdminNewTripView_Previews: PreviewProvider {
    static var previews: some View {
        AdminNewTripView()
    }
}
