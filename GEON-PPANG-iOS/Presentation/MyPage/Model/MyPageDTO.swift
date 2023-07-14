//
//  MyPageDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import Foundation

struct MyPageDTO: Codable {
    let memberNickname: String
    let mainPurpose: String
    let breadType: BreadResponseType
}

extension MyPageDTO {
    
    static func dummyData() -> MyPageDTO {
        return .init(memberNickname: "Id",
                     mainPurpose: "HEALTH",
                     breadType: .init(breadTypeID: 1,
                                      breadTypeName: "맛 • 다이어트",
                                      isGlutenFree: true,
                                      isVegan: true,
                                      isNutFree: true,
                                      isSugarFree: true))
    }
}
