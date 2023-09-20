//
//  MemberService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/18.
//

import Foundation

import Moya

enum MemberService {
    case setNickname(request: NicknameRequestDTO)
    case fetchNickname
}

extension MemberService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .setNickname, .fetchNickname:
            return URLConstant.nickname
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setNickname:
            return .post
        case .fetchNickname:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .setNickname(request: let data):
            return .requestJSONEncodable(data)
        case .fetchNickname:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .setNickname:
            return NetworkConstant.header(.accessToken)
        case .fetchNickname:
            return NetworkConstant.header(.accessToken)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}
