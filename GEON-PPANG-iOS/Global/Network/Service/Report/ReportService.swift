//
//  ReportService.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/09/29.
//

import Foundation

import Moya

enum ReportService {
    case writeReport(reviewID: Int, content: ReportRequestDTO)
}

extension ReportService: TargetType {
    
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .writeReport(reviewID: let reviewID, _):
            return URLConstant.report + "/\(reviewID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .writeReport:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .writeReport(_, content: let content):
            return .requestJSONEncodable(content)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.header(.accessToken)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
