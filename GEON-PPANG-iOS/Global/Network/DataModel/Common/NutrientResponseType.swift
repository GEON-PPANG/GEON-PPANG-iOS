//
//  NutrientResponseType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/19.
//

import Foundation

struct NutrientResponseType: Codable {
    let nutrientTypeID: Int
    let nutrientTypeName: String
    let isNutrientOpen: Bool
    let isIngredientOpen: Bool
    let isNotOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case nutrientTypeID = "nutrientTypeId"
        case nutrientTypeName
        case isNutrientOpen
        case isIngredientOpen
        case isNotOpen
    }
}
