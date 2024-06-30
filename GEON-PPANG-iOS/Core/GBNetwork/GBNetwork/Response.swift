//
//  ResponseType.swift
//  GBNetwork
//
//  Created by 이성민 on 6/29/24.
//

import Foundation

public struct Response<DTO: Decodable>: Decodable {
    public let code: Int
    public let message: String
    public let data: DTO
}
