//
//  BakeryTypeProtocol.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import Foundation

protocol BakeryTypeProtocol {
    var isGlutenFree: Bool { get }
    var isNutFree: Bool { get }
    var isVegan: Bool { get }
    var isSugarFree: Bool { get }
}

protocol BakeryListProtocol {
    var bakeryName: String { get }
    var bookmarkCount: Int { get }
    var isBooked: Bool { get }

    var isHACCP: Bool { get }
    var isVegan: Bool { get }
    var isNonGMO: Bool { get }
    
    var firstNearStation: String { get }
    var secondNearStation: String? { get }
    
    var breadType: BreadType { get }
}
//
//struct Bakery: BakeryListProtocol {
//    var bakeryName: String
//    var bookmarkCount: Int
//    var isBooked: Bool
//
//    var isHACCP: Bool
//    var isVegan: Bool
//    var isNonGMO: Bool
//
//    var firstNearStation: String
//    var secondNearStation: String? = ""
//
//    var breadType: BreadType
//
//}
