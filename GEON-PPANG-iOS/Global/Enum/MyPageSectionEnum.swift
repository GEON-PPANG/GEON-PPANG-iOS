//
//  MyPageEnum.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import Foundation

enum MyPageSectionEnum: String, CaseIterable {
    
    case basic
    case version
    
    var items: [String] {
        switch self {
        case .basic: return ["이용약관", "문의하기"]
        case .version: return ["버전 정보"]
        }
    }
    
}
