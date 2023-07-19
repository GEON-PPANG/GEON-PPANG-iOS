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
    
    func isNoneSelected() -> Bool {
        if isGlutenFree == false && isVegan == false && isNutFree == false && isSugarFree == false {
            return true
        } else {
            return false
        }
    }
}
