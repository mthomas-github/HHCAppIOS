//
//  NumberFormatterExtension.swift
//  HHC
//
//  Created by Michael Thomas on 11/17/20.
//

import Foundation


extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
