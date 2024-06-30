//
//  GBDataError.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

enum MemberError: String, Error {
    /// 유효하지 않은 토큰 ( 401 )
    case invalidToken = "엑세스 토큰이 없습니다"
    /// 만료된 토큰 ( 401 )
    case expiredToken = "만료된 토큰입니다"
    /// 그 외의 오류 ( 404, 500번대 )
    case otherError
}
