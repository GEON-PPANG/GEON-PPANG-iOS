//
//  WriteReviewDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import Foundation

struct WriteReviewDTO: Codable {
    let bakeryID: Int
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

struct SingleKeyword: Codable, Equatable {
    let keywordName: String
}

struct KeywordDescriptionList: Codable {
    enum Keyword: String, CaseIterable {
        case delicious = "맛있어요"
        case kind = "친절해요"
        case special = "특별한 메뉴"
        case zeroWaste = "제로 웨이스트"
    }
    
    enum Request: String, CaseIterable {
        case delicious = "DELICIOUS"
        case kind = "KIND"
        case special = "SPECIAL_MENU"
        case zeroWaste = "ZERO_WASTE"
    }
}
