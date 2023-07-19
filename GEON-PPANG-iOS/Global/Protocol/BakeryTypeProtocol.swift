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
    var bakeryId: Int { get }
    var bakeryName: String { get }
    var bakeryPicture: String { get }
    var isHACCP: Bool { get }
    var isVegan: Bool { get }
    var isNonGMO: Bool { get }
    var firstNearStation: String { get }
    var secondNearStation: String? { get }
    var isBookMarked: Bool { get }
    var bookMarkCount: Int { get }
    var reviewCount: Int { get }
    var breadType: BreadResponseType { get }
}
