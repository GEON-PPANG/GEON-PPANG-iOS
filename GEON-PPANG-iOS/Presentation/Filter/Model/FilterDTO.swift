//
//  FilterDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import Foundation

struct FilterRequestDTO {
    let mainPurpose: String
    let breadType: BreadType
    let nutrientType: NutrientType
}

struct BreadType {
    var isGlutenFree: Bool
    var isVegan: Bool
    var isNutFree: Bool
    var isSugarFree: Bool
    
    func isNoneSelected() -> Bool {
        if isGlutenFree == false && isVegan == false && isNutFree == false && isSugarFree == false {
            return true
        } else {
            return false
        }
    }
}

struct NutrientType {
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
}
