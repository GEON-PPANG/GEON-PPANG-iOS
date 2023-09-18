//
//  SignUpResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/10.
//

import Foundation

struct SignUpResponseDTO: Codable {
    let memberID: Int
    let type: String
    let email: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case type
        case email
        case role
    }
}
