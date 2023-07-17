//
//  NetworkConstant.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct NetworkConstant {
    static let noTokenHeader = ["Content-Type": "application/json"]
    static var hasTokenHeader = ["Content-Type": "application/json",
                                 "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5MDc3NzcwMiwiZW1haWwiOiJleGFtcGxlQHNvcHQuY29tIiwibWVtYmVySWQiOjExfQ.4wcpdoi-GZM9I9kMd7xKsTk6NM6G3OFjNOGZelOEGICFWmr8KAORnnMd34hvNBblj_rWQmlu0ze2woziycaq5w"]
}
