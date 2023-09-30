//
//  ReportResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/09/29.
//

import Foundation

struct ReportResponseDTO: Codable {
    var reviewReportID: Int
    
    enum CodingKeys: String, CodingKey {
        case reviewReportID = "reviewReportId"
    }
}
