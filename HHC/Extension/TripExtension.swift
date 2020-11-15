//
//  TripExtension.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import Foundation

extension Trip: Identifiable {}
extension Trip: Equatable {
    public static func ==(lhs: Trip, rhs: Trip) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
}
extension Trip: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id + name)
    }
}
