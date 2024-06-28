//
//  PostFilterResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/27/24.
//

import Foundation

struct PostFilterResponseDTO: Decodable {
    let memberId: Int
    let mainPurpose: String
    let nickname: String
    let breadTypeList: [BreadType]
    let nutrientTypeList: [NutrientType]
}

extension PostFilterResponseDTO {
    struct BreadType: Decodable {
        let breadTypeId: Int
    }
    
    struct NutrientType: Decodable {
        let nutrientTypeId: Int
    }
}

extension PostFilterResponseDTO {
    func toDomain() {
        
    }
}
