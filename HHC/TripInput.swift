//
//  TripInput.swift
//  HHC
//
//  Created by Michael Thomas on 11/17/20.
//

import SwiftUI

class TripInput: ObservableObject {
    static let clearCode = String.Element(Unicode.Scalar(7))
    @Published var tripName: String = ""
    @Published var tripDescription: String = ""
    @Published var tripMaxSeats: Int = 50
    @Published var tripStartDate: Date = Date()
    @Published var tripEndDate: Date = Date()
    @Published var tripDatesTenative: Bool = true
    @Published var tripTotalCost: Double = 0
    @Published var hasPaymentPlan: Bool = false
    @Published var coverImageKey: String = ""
    @Published var galleryImages: [String] = []
    
    func clear() {
        self.tripName = ""
        self.tripDescription = ""
        self.tripMaxSeats = 50
        self.tripStartDate = Date()
        self.tripEndDate = Date()
        self.tripDatesTenative = true
        self.tripTotalCost = 0
        self.hasPaymentPlan = false
        self.galleryImages = []
        self.coverImageKey = ""
    }
}
