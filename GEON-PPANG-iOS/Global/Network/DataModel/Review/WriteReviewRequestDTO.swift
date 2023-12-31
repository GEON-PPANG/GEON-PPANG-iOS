//
//  WriteReviewDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import Foundation

struct WriteReviewRequestDTO: Codable {
    var bakeryID: Int
    var isLike: Bool
    var keywordList: [SingleKeyword]
    var reviewText: String

    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case isLike
        case keywordList
        case reviewText
    }
}

extension WriteReviewRequestDTO {
    
    static func empty() -> Self {
        return .init(bakeryID: 0, isLike: false, keywordList: [], reviewText: "")
    }
}

struct SingleKeyword: Codable, Equatable {
    let keywordName: String
}

struct KeywordDescriptionList: Codable {
    enum Keyword: String, CaseIterable {
        case delicious = "맛있어요"
        case zeroWaste = "제로 웨이스트"
        case special = "특별한 메뉴"
        case kind = "친절해요"
    }
    
    enum Request: String, CaseIterable {
        case delicious = "DELICIOUS"
        case zeroWaste = "ZERO_WASTE"
        case special = "SPECIAL_MENU"
        case kind = "KIND"
    }
}

extension KeywordDescriptionList {
    
    static let keywordList = KeywordDescriptionList.Keyword.allCases.map { $0.rawValue }
    
    static let requestList = KeywordDescriptionList.Request.allCases.map { $0.rawValue }
    
}
