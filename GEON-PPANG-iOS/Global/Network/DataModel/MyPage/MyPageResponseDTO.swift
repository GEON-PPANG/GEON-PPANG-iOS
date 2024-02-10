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
    
    struct BreadType: Codable {
        let breadTypeId: Int
        
        func toString() -> String {
            switch self.breadTypeId {
            case 1: return "글루텐프리"
            case 2: return "비건"
            case 3: return "넛프리"
            case 4: return "대체당"
            default: return ""
            }
        }
    }
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
