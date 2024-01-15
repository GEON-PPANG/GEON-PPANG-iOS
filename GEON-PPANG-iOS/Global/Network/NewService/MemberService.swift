//
//  MemberService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum MemberService {
    case postTypes(request: FilterRequestDTO)
    case getTypes
    case postNickname(request: NicknameRequestDTO)
    case getNickname
    case bookmarks
    case reviews
    case member
}

extension MemberService: GBService {
    var domain: GBDomain {
        return .member
    }
    
    var urlPath: String {
        switch self {
        case .postTypes, .getTypes:
            return URLConstant.Member.types
        case .postNickname, .getNickname:
            return URLConstant.Member.nickname
        case .bookmarks:
            return URLConstant.Member.bookmarks
        case .reviews:
            return URLConstant.Member.reviews
        case .member:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postTypes, .postNickname:
            return .post
        case .getTypes, .bookmarks, .reviews, .getNickname, .member:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postTypes(request: let request):
            return .requestJSONEncodable(request)
        case .postNickname(request: let request):
            return .requestJSONEncodable(request)
        case .getTypes, .getNickname, .bookmarks, .reviews, .member:
            return .requestPlain
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .postTypes:
            return .accessToken
        case .getTypes:
            return .accessToken
        case .postNickname:
            return .accessToken
        case .getNickname:
            return .accessToken
        case .bookmarks:
            return .accessToken
        case .reviews:
            return .accessToken
        case .member:
            return .accessToken
        }
    }
    
}


