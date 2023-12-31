//
//  ReportRequestDTO.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/09/29.
//

import Foundation

struct ReportRequestDTO: Codable {
    var content: String
    var reportCategory: String
    
    init(content: String = "", reportCategory: String = "") {
        self.content = content
        self.reportCategory = reportCategory
    }
}

enum ReportCategory: String {
    case advertising = "ADVERTISING"
    case hate = "HATE"
    case copyright = "COPYRIGHT"
    case etc = "ETC"
}
