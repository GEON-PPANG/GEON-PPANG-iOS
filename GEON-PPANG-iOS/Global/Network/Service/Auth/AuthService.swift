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
    case signUp(request: SignUpRequestDTO)
    case refreshToken
    case withdraw
    case appleWithdraw
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
        case .signUp:
            return URLConstant.signup
        case .refreshToken:
            return URLConstant.refreshToken
        case .withdraw, .appleWithdraw:
            return URLConstant.withdraw
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkEmail, .checkNickname, .login, .signUp:
            return .post
        case .refreshToken:
            return .get
        case .withdraw, .appleWithdraw:
            return .delete
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
        case .signUp(request: let data):
            return .requestJSONEncodable(data)
        case .refreshToken:
            return .requestPlain
        case .withdraw, .appleWithdraw:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .checkEmail, .checkNickname, .login:
            return NetworkConstant.header(.noToken)
        case .signUp:
            return NetworkConstant.header(.platformToken)
        case .refreshToken:
            return NetworkConstant.header(.accessAndRefreshToken)
        case .withdraw:
            return NetworkConstant.header(.accessToken)
        case .appleWithdraw:
            return NetworkConstant.header(.appleRefresh)
        }
    }
}
