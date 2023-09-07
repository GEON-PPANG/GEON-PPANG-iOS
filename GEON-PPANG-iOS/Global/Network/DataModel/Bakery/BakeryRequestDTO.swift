//
//  BakeryRequestDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/03.
//

import Foundation

struct BakeryRequestDTO: Codable {
    var sortingOption: String
    var personalFilter: Bool
    var isHard: Bool
    var isDessert: Bool
    var isBrunch: Bool
}
