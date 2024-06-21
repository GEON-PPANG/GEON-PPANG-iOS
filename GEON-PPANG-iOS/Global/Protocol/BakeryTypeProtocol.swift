//
//  BakeryTypeProtocol.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import Foundation

protocol BakeryTypeProtocol {
    
    var breadTypeID: Int { get }
    var name: String { get }
    var isGlutenFree: Bool { get }
    var isVegan: Bool { get }
    var isNutFree: Bool { get }
    var isSugarFree: Bool { get }
}

protocol BakeryListProtocol {
    
    var bakeryID: Int { get }
    var name: String { get }
    var picture: String { get }
    var isHACCP: Bool { get }
    var isVegan: Bool { get }
    var isNonGMO: Bool { get }
    var station: String { get }
    var bookmarkCount: Int { get }
    var reviewCount: Int { get }
    var breadTypeList: [OldBreadType] { get }
}
