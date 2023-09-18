//
//  NicknameResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/18.
//

import Foundation

struct NicknameResponseDTO: Codable {
    let nickname: String
    let role: String
    let memberId: Int
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case role
        case memberId = "memberID"
    }
}
