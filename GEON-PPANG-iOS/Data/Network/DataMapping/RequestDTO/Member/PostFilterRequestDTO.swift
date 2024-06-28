//
//  PostFilterRequestDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/27/24.
//

import Foundation

struct PostFilterRequestDTO: Encodable {
    let mainPurpose: String
    let breadTypeList: [BakeryType]
    let nutrientTypeList: [NutrientType]
}
