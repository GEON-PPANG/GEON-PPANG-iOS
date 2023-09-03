//
//  AuthService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum AuthService {
    case checkEmail(requestEmail: EmailRequestDTO)
    case login(request: LoginRequestDTO)
}

extension AuthService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .checkEmail:
            return URLConstant.checkEmail
        case .login:
            return URLConstant.login
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkEmail, .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .checkEmail(requestEmail: let data):
            return .requestJSONEncodable(data)
        case .login(request: let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.noTokenHeader
        }
    }    
}
