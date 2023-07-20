//
//  Int+.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/20.
//

import Foundation

extension Int {
    
    var priceText: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            var priceString = numberFormatter.string(for: self) ?? "-1"
            priceString = priceString + "원"
            return priceString
        }
    }
}
