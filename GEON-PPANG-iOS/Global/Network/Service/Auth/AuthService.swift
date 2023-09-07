//
//  AuthService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum AuthService {
    case checkEmail(request: EmailRequestDTO)
    case checkNickname(request: NicknameRequestDTO)
    
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
        case .checkNickname:
            return URLConstant.checkNickname
        case .login:
            return URLConstant.login
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkEmail, .checkNickname, .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .checkEmail(request: let data):
            return .requestJSONEncodable(data)
        case .checkNickname(request: let data):
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
