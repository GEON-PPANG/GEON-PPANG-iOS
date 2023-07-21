//
//  NutrientRequestType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/19.
//

import Foundation

struct NutrientRequestType: Codable {
    var isNutrientOpen: Bool
    var isIngredientOpen: Bool
    var isNotOpen: Bool
    
    func isNoneSelected() -> Bool {
        if isNutrientOpen == false && isIngredientOpen == false && isNotOpen == false {
            return true
        } else {
            return false
        }
    }
    
    mutating func clearData() {
        isNutrientOpen = false
        isIngredientOpen = false
        isNotOpen = false
    }
}
