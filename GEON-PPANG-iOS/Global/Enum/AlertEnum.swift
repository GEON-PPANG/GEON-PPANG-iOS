//
//  AlertEnum.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/30.
//

import UIKit

enum AlertType {
    case logout
    case leave
    
    var title: String {
        switch self {
        case .logout: return "로그아웃"
        case .leave: return "회원탈퇴"
        }
    }
    
    var subtitle: String {
        switch self {
        case .logout: return "정말로 로그아웃하실 건가요?"
        case .leave: return "회원님의 정보가 사라집니다.\n정말로 떠나실 건가요?"
        }
    }
    
    var cancel: String {
        switch self {
        case .logout: return "아니요"
        case .leave: return "더 써볼래요"
        }
    }
    
    var accept: String {
        switch self {
        case .logout: return "네"
        case .leave: return "떠날래요"
        }
    }
    
    var image: UIImage {
        switch self {
        case .logout: return .iconSad
        case .leave: return .iconSad
        }
    }
}
