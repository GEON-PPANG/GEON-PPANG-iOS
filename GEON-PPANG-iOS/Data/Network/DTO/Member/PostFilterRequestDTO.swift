//
//  PostFilterRequestDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

struct PostFilterRequestDTO: Encodable {
    let mainPurpose: String
    let breadTypeList: [Int]
    let nutrientTypeList: [Int]
    
    init(purpose: String, breadType: [Int], nutrientType: [Int]) {
        self.mainPurpose = purpose
        self.breadTypeList = breadType
        self.nutrientTypeList = nutrientType
    }
}
