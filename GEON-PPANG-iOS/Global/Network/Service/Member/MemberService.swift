//
//  MemberService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/18.
//

import Foundation

import Moya

//enum MemberService {
//    case setNickname(request: NicknameRequestDTO)
//    case fetchNickname
//    case withdraw
//    case appleWithdraw
//    case logout
//}
//
//extension MemberService: TargetType {
//    var baseURL: URL {
//        return URL(string: Config.baseURL)!
//    }
//    
//    var path: String {
//        switch self {
//        case .setNickname, .fetchNickname:
//            return URLConstant.nickname
//        case .logout:
//            return URLConstant.logout
//        case .withdraw, .appleWithdraw:
//            return URLConstant.withdraw
//        }
//    }
//    
//    var method: Moya.Method {
//        switch self {
//        case .setNickname, .logout:
//            return .post
//        case .fetchNickname:
//            return .get
//        case .withdraw, .appleWithdraw:
//            return .delete
//        }
//    }
//    
//    var task: Moya.Task {
//        switch self {
//        case .setNickname(request: let data):
//            return .requestJSONEncodable(data)
//        case .fetchNickname:
//            return .requestPlain
//        case .logout:
//            return .requestPlain
//        case .withdraw, .appleWithdraw:
//            return .requestPlain
//        }
//    }
//    
//    var headers: [String: String]? {
//        switch self {
//        case .setNickname:
//            return NetworkConstant.header(.accessToken)
//        case .fetchNickname:
//            return NetworkConstant.header(.accessToken)
//        case .logout:
//            return NetworkConstant.header(.accessToken)
//        case .withdraw:
//            return NetworkConstant.header(.accessToken)
//        case .appleWithdraw:
//            return NetworkConstant.header(.appleRefresh)
//        }
//    }
//    
//    var validationType: ValidationType {
//        return .successCodes
//    }
//    
//}
