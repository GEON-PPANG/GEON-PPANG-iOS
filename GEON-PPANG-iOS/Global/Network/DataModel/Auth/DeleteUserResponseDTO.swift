//
//  DeleteUserResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/18.
//

import Foundation

struct DeleteUserResponseDTO: Codable {
    let memberID: Int
    
    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
    }
}
