//
//  RawResponse.swift
//  GBNetwork
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

public struct RawResponse {
    public let data: Data
    public let httpResponse: HTTPURLResponse
    
    init(data: Data, httpResponse: HTTPURLResponse) {
        self.data = data
        self.httpResponse = httpResponse
    }
}

extension RawResponse {
    public func decode<DTO: Decodable>(to type: DTO.Type) throws -> Response<DTO> {
        do {
            return try JSONDecoder().decode(Response<DTO>.self, from: self.data)
        } catch {
            throw GBNetworkError.decodingFailure(.dtoDecodingError)
        }
    }
}
