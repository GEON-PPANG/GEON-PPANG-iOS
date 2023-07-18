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
    var keywordList: [String]
    var reviewText: String

    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case isLike
        case keywordList
        case reviewText
    }
}

struct KeywordList: Codable {
    enum Keyword: String, CaseIterable {
        case delicious = "맛있어요"
        case kind = "친절해요"
        case special = "특별한 메뉴"
        case zeroWaste = "제로 웨이스트"
    }
}
