//
//  BookmarksService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum BookmarksService {
    case bookmark(bakeryID: Int, request: BookmarkRequestDTO)
}

extension BookmarksService: GBService {
    
    var domain: GBDomain {
        return .bookmarks
    }
    
    var urlPath: String {
        switch self {
        case .bookmark(bakeryID: let bakeryID, _): return "/\(bakeryID)"
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .bookmark: return .accessToken
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookmark: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bookmark(_, request: let request):
            return .requestJSONEncodable(request)
        }
    }
}
