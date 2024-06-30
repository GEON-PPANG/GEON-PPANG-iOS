//
//  GBDataError.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

enum GBDataError: String, Error {
    /// request에 빠진 값이 있는 경우 ( 400 )
    case missingValue
    /// 유효하지 않은 토큰 ( 401 )
    case invalidToken = "엑세스 토큰이 없습니다"
    /// 만료된 토큰 ( 401 )
    case expiredToken = "만료된 토큰입니다"
    /// 옳지 않은 request 값 ( 404 )
    case invalidRequest
    /// 서버 에러 ( 500 )
    case unknownError
}
