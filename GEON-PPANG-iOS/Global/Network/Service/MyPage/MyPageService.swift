//
//  MyPageService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum MyPageService {
    case bookmarks
}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .bookmarks:
            return URLConstant.bookmarks
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookmarks:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bookmarks:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
}
