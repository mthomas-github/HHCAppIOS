//
//  TripStore.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI
import Combine

final class TripStore: ObservableObject {
    
    private enum Keys {
        static let name = "name"
        static let description = "description"
        static let total = "total"
        static let coverImage = "coverImage"
        static let phase = "phase"
        static let startDate = "startDate"
        static let endDate = "endDate"
        static let tenative = "tenative_enabled"
        static let gallery = "gallery"
        static let members = "members"
        static let maxPeople = "maxpeople"
        static let paymentPlan = "payment_plan_enabled"
        
    }
    
    private let cancellable: Cancellable
    private let defaults: UserDefaults
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        defaults.register(defaults: [
            Keys.name: "",
            Keys.description: "",
            Keys.total: 0,
            Keys.coverImage: "",
            Keys.phase: TripPhase.new.rawValue,
            Keys.startDate: Date(),
            Keys.endDate: Date(),
            Keys.tenative: true,
            Keys.gallery: [""],
            Keys.members: [""],
            Keys.maxPeople: 50,
            Keys.paymentPlan: false
        ])
        
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }
    
    enum TripPhase: String, CaseIterable {
      case new
      case interested
      case signUp
      case waitlist
      case closed
    }
    
    var name: String {
        set { defaults.set(newValue, forKey: Keys.name) }
        get { defaults.string(forKey: Keys.name)! }
    }
    
    var description: String {
        set { defaults.set(newValue, forKey: Keys.description) }
        get { defaults.string(forKey: Keys.description)! }
    }
    
    var total: Float {
        set { defaults.set(newValue, forKey: Keys.total) }
        get { defaults.float(forKey: Keys.total) }
    }
    
    var coverImage: String {
        set { defaults.set(newValue, forKey: Keys.coverImage) }
        get { defaults.string(forKey: Keys.coverImage)! }
    }
    
    var tripPhase: TripPhase {
        get {
            return defaults.string(forKey: Keys.phase)
                .flatMap { TripPhase(rawValue: $0) } ?? .new
        }
        
        set {
            defaults.set(newValue.rawValue, forKey: Keys.phase)
        }
    }
    
    var startDate: Date {
        set { defaults.set(Date(), forKey: Keys.startDate) }
        get { defaults.object(forKey: Keys.startDate) as! Date}
    }
    
    var endDate: Date {
        set { defaults.set(Date(), forKey: Keys.endDate) }
        get { defaults.object(forKey: Keys.endDate) as! Date}
    }
    
    var tenative: Bool {
        set { defaults.set(newValue, forKey: Keys.tenative) }
        get { defaults.bool(forKey: Keys.tenative) }
    }
    
    var gallery: [String] {
        set { defaults.set(newValue, forKey: Keys.gallery)}
        get { defaults.stringArray(forKey: Keys.gallery)!}
    }
    
    var members: [String] {
        set { defaults.set(newValue, forKey: Keys.members)}
        get { defaults.stringArray(forKey: Keys.members)!}
    }
    
    var maxPeople: Int {
        set { defaults.set(newValue, forKey: Keys.maxPeople) }
        get { defaults.integer(forKey: Keys.maxPeople) }
    }
    
    var paymentPlan: Bool {
        set { defaults.set(newValue, forKey: Keys.paymentPlan) }
        get { defaults.bool(forKey: Keys.paymentPlan) }
    }
    
}


