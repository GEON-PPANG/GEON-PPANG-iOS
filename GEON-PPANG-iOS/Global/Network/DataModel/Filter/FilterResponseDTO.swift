//
//  FilterResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct FilterResponseDTO: Codable {
    let memberID: Int
    let mainPurpose: String
    let nickname: String
    let breadTypeList: [BreadType]
    let nutrientTypeList: [NutrientType]
    
    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case mainPurpose
        case nickname
        case breadTypeList
        case nutrientTypeList
    }
    
    struct NutrientType: Codable {
        let nutrientTypeId: Int
    }
}
