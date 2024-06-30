//
//  PostFilterResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

struct PostFilterResponseDTO: Decodable {
    let memberID: Int
    let mainPurpose: String
    let nickname: String
    let breadTypeList: [BreadTypeList]
    let nutrientTypeList: [NutrientTypeList]

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case mainPurpose
        case nickname
        case breadTypeList
        case nutrientTypeList
    }
}

extension PostFilterResponseDTO {
    struct BreadTypeList: Decodable {
        let breadTypeID: Int

        enum CodingKeys: String, CodingKey {
            case breadTypeID = "breadTypeId"
        }
    }

    struct NutrientTypeList: Decodable {
        let nutrientTypeID: Int

        enum CodingKeys: String, CodingKey {
            case nutrientTypeID = "nutrientTypeId"
        }
    }
}
