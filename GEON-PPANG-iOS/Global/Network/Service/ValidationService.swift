//
//  ValidationService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum ValidationService {
    case checkEmail(request: EmailRequestDTO)
    case checkNickname(request: NicknameRequestDTO)
}

extension ValidationService: GBService {
    
    var domain: GBDomain {
        return .validation
    }
    
    var urlPath: String {
        switch self {
        case .checkEmail: return URLConstant.Validation.email
        case .checkNickname: return URLConstant.Validation.nickname
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .checkEmail, .checkNickname: return .noToken
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkEmail, .checkNickname: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .checkEmail(request: let data):
            return .requestJSONEncodable(data)
        case .checkNickname(request: let data):
            return .requestJSONEncodable(data)
        }
    }
}
