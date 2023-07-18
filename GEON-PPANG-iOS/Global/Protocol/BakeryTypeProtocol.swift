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
    var bookMarkCount: Int { get }
    var isBookMarked: Bool { get }
    var reviewCount: Int { get }
    var bakeryPicture: String { get }

    var isHACCP: Bool { get }
    var isVegan: Bool { get }
    var isNonGMO: Bool { get }
    
    var firstNearStation: String { get }
    var secondNearStation: String? { get }
    
    var breadType: BreadResponseType { get }
}
