//
//  NutrientType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/21/24.
//

import Foundation

enum NutrientType: Codable {
    case nutrient
    case ingredient
    case all
}

extension NutrientType {
    var id: Int {
        switch self {
        case .nutrient: 1
        case .ingredient: 2
        case .all: 3
        }
    }
}
