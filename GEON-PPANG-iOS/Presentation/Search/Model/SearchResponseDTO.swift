//
//  SearchResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import Foundation

// MARK: - SearchResponseDTO

struct SearchResponseDTO: Hashable {
    let resultCount: Int
    let bakeryList: [SearchBakeryList]
}

// MARK: - SearchBakeryList

struct SearchBakeryList: Hashable, BakeryListProtocol {    
    let bakeryID: Int
    let bakeryName: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    var breadType: BreadResponseType
    let firstNearStation: String
    var secondNearStation: String?
    let isBooked: Bool
    let bookmarkCount: Int
    let bakeryPicture: String
}

extension SearchResponseDTO {
    static let item: [SearchResponseDTO] = [SearchResponseDTO(resultCount: 0, bakeryList: SearchBakeryList.searchBakeryItem)]
}

extension SearchBakeryList {
    static let searchBakeryItem: [SearchBakeryList] = [SearchBakeryList(bakeryID: 1, bakeryName: "히히히히", isHACCP: true, isVegan: true, isNonGMO: true, breadType: .searchBreadType, firstNearStation: "헤헤", secondNearStation: "두번째역", isBooked: true, bookmarkCount: 5, bakeryPicture: "")]
}

extension BreadResponseType {
    static let searchBreadType: BreadResponseType = BreadResponseType(breadTypeID: 3, breadTypeName: "글루텐프리", isGlutenFree: true, isVegan: true, isNutFree: false, isSugarFree: true)
}
