//
//  PurposeType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/21/24.
//

import Foundation

enum PurposeType: String {
    case health
    case diet
    case vegan
}

extension PurposeType {
    func upperCased() -> String {
        return self.rawValue.uppercased()
    }
}
