//
//  SignInPropertyType.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/26.
//

import Foundation

enum SignInPropertyType: CaseIterable {
    
    case email, loginEmail
    case password, loginPassword
    case checkPassword
    case nickname
    
    var title: String {
        switch self {
        case .email, .loginEmail: return "이메일"
        case .password, .loginPassword: return "비밀번호"
        case .checkPassword: return "비밀번호 재확인"
        case .nickname: return "닉네임"

        }
    }
    
    var placeHolder: String {
        switch self {
        case .email, .loginEmail: return  "이메일을 입력해주세요"
        case .password: return "영문, 숫자 포함 8자리이상"
        case .loginPassword: return "비밀번호를 입력해주세요"
        case .checkPassword: return "비밀번호를 재입력해주세요"
        case .nickname: return "닉네임 10자 이내, 특수문자 금지"
        }
    }
}
