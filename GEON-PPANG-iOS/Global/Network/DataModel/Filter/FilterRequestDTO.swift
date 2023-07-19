//
//  FilterDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import Foundation

struct FilterRequestDTO: Codable {
    var mainPurpose: String
    var breadType: BreadRequestType
    var nutrientType: NutrientRequestType
    
    static var sharedData = FilterRequestDTO()
    
    private init() {
        self.mainPurpose = ""
        self.breadType = .init(isGlutenFree: false,
                               isVegan: false,
                               isNutFree: false,
                               isSugarFree: false)
        self.nutrientType = .init(isNutrientOpen: false,
                                  isIngredientOpen: false,
                                  isNotOpen: false)
    }
}

struct BreadRequestType: Codable {
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
}
