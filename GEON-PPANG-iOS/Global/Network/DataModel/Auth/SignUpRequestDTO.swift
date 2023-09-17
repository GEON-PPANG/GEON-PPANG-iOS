//
//  SignUpRequestDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/09.
//

import Foundation

struct SignUpRequestDTO: Codable {
    let platformType: PlatformType
    let email: String
    let password: String
    let nickname: String
}
