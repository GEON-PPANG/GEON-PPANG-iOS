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
                                 "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "Authorization") ?? "")"]
}
