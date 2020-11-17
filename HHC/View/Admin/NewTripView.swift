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
    @State var shouldShowImagePicker = false
    @State var shouldShowPicker = false
    @State var image: UIImage?
    @State var coverImageKey: String = ""
    @State var galleryImages: [String] = []
    @State var show = false
    @State var selected : [SelectedImages] = []
    @State var tripName: String = ""
    @State var tripDescription: String = ""
    @State var tripMaxSeats: Int = 50
    @State var tripStartDate: Date = Date()
    @State var tripEndDate: Date = Date()
    @State var tripDatesTenative: Bool = true
    @State var tripTotalCost: Double = 0.00
    @State var hasPaymentPlan: Bool = false
    
    let uploadImages = DispatchGroup()
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Trip Name", text: $tripName)
                    TextField("Trip Description", text: $tripDescription)
                    Stepper(value: $tripMaxSeats, in: 0...100) {
                        Text("There Will be \(tripMaxSeats) Seats Open")
                    }
                }
                Section(header: Text("Trip Dates")) {
                    DatePicker("Trip Start Date", selection: $tripStartDate)
                    DatePicker("Trip End Date", selection: $tripEndDate)
                    Toggle(isOn: $tripDatesTenative) {
                        Text("Date(s) Tenative?")
                    }
                }
                Section(header: Text("Trip Cost")) {
                    TextField("Price", value: $tripTotalCost, formatter: NumberFormatter.currency)
                    Toggle(isOn: $hasPaymentPlan) {
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
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
            }
            .navigationBarTitle("New Trip")
        }
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
                    galleryImages.append(key)
                    uploadImages.leave()
                } else {
                    coverImageKey = key
                    self.image = nil
                }
                
            case .failure(let error):
                print("Failed to upload - \(error)")
            }
            
        }
    }
    
    func save() {
        let convertST = Temporal.DateTime(self.tripStartDate)
        let convertET = Temporal.DateTime(self.tripEndDate)
        let newTrip = Trip(name: self.tripName, description: self.tripDescription, total: self.tripTotalCost, coverImageKey: self.coverImageKey, tripPhase: Phase(rawValue: Phase.new.rawValue), startDate: convertST, endDate: convertET, tenative: self.tripDatesTenative, gallery: self.galleryImages, members: [""], maxSeats: self.tripMaxSeats, paymentPlan: self.hasPaymentPlan)
        
        Amplify.DataStore.save(newTrip) { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print("there was an error: \(error)")
            }
        }
        
    }
}

struct NewTripView_Previews: PreviewProvider {
    static var previews: some View {
        NewTripView()
    }
}
