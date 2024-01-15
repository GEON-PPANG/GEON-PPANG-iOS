//
//  AuthService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum AuthService {
    
    case login(request: LoginRequestDTO)
    case signUp(request: SignUpRequestDTO)
    case logout
    case refreshToken
    case withdraw
    case appleWithdraw
}

extension AuthService: GBService {
    
    var domain: GBDomain {
        return .auth
    }
    
    var urlPath: String {
        switch self {
        case .signUp: return URLConstant.Auth.signup
        case .login: return URLConstant.Auth.login
        case .logout: return URLConstant.Auth.logout
        case .refreshToken: return URLConstant.Auth.refresh
        case .withdraw, .appleWithdraw: return URLConstant.Auth.withdraw
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .signUp: return .platformToken
        case .login: return .noToken
        case .logout, .withdraw: return .accessToken
        case .refreshToken: return .accessAndRefreshToken
        case .appleWithdraw: return .appleRefresh
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp, .login, .logout: return .post
        case .refreshToken: return .get
        case .withdraw, .appleWithdraw: return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(request: let data):
            return .requestJSONEncodable(data)
        case .signUp(request: let data):
            return .requestJSONEncodable(data)
        case .logout, .withdraw, .appleWithdraw, .refreshToken: return .requestPlain
        }
    }
}
