//
//  ReportService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum ReportService {
    case writeReport(reviewID: Int, content: ReportRequestDTO)
}

extension ReportService: GBService {
    var domain: GBDomain {
        return .report
    }
    
    var urlPath: String {
        switch self {
        case .writeReport(reviewID: let reviewID, _):
            return URLConstant.Report.review + "/\(reviewID)"
        }
    }
    
    var path: String {
        switch self {
        case .writeReport(reviewID: let reviewID, _):
            return URLConstant.Report.review + "/\(reviewID)"
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
    
    var headerType: GBHeaderFields {
        switch self {
        case .writeReport: return .accessToken
        }
    }
}
