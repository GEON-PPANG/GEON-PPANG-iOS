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
    
    init(isNutrientOpen: Bool = false,
         isIngredientOpen: Bool = false,
         isNotOpen: Bool = false) {
        self.isNutrientOpen = isNutrientOpen
        self.isIngredientOpen = isIngredientOpen
        self.isNotOpen = isNotOpen
    }
}

extension NutrientRequestType {
    
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
