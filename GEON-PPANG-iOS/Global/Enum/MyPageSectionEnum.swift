//
//  MyPageEnum.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import Foundation

enum MyPageSectionEnum: String, CaseIterable {
    
    case terms
    case questions
    
    var items: [String] {
        switch self {
        case .terms: return ["이용약관"]
        case .questions: return ["자주 묻는 질문", "문의하기"]
        }
    }
    
}
