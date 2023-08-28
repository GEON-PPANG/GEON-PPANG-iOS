//
//  BreadRequestType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/19.
//

import Foundation

struct BreadRequestType: Codable {
    var isGlutenFree: Bool
    var isVegan: Bool
    var isNutFree: Bool
    var isSugarFree: Bool
    
    init(isGlutenFree: Bool = false,
         isVegan: Bool = false,
         isNutFree: Bool = false,
         isSugarFree: Bool = false) {
        self.isGlutenFree = isGlutenFree
        self.isVegan = isVegan
        self.isNutFree = isNutFree
        self.isSugarFree = isSugarFree
    }
}

extension BreadRequestType {
    
    func isNoneSelected() -> Bool {
        
        if isGlutenFree == false && isVegan == false && isNutFree == false && isSugarFree == false {
            return true
        } else {
            return false
        }
    }
    
    mutating func clearData() {
        
        isGlutenFree = false
        isVegan = false
        isNutFree = false
        isSugarFree = false
    }
}
