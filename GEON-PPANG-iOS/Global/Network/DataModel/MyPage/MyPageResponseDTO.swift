//
//  MyPageResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import Foundation

struct MyPageResponseDTO: Codable {
    let memberNickname: String
    let mainPurpose: String
    let breadTypeList: [BreadType]
}

extension MyPageResponseDTO {
    
    static func dummyData() -> MyPageResponseDTO {
        
        return .init(memberNickname: "Id",
                     mainPurpose: "NONE",
                     breadTypeList: [.init(breadTypeId: 1)])
    }
    
    static func emptyData() -> MyPageResponseDTO {
        
        return .init(memberNickname: "",
                     mainPurpose: "",
                     breadTypeList: [])
    }
}
