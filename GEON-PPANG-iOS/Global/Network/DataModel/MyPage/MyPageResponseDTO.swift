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
    let breadType: BreadResponseType
}

extension MyPageResponseDTO {
    
    static func dummyData() -> MyPageResponseDTO {
        
        return .init(memberNickname: "Id",
                     mainPurpose: "NONE",
                     breadType: .init(breadTypeID: 1,
                                      name: "맛 • 다이어트",
                                      isGlutenFree: true,
                                      isVegan: true,
                                      isNutFree: false,
                                      isSugarFree: true))
    }
    
    static func emptyData() -> MyPageResponseDTO {
        
        return .init(memberNickname: "",
                     mainPurpose: "",
                     breadType: .emptyBreadType())
    }
}
