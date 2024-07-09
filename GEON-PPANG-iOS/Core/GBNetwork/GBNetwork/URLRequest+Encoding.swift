//
//  URLRequest+Encoding.swift
//  GBNetwork
//
//  Created by 이성민 on 6/29/24.
//

import Foundation

extension URLRequest {
    func encode(queries: [String: Any]) throws -> URLRequest {
        guard let url = self.url else {
            throw GBNetworkError.requestEncodingFailure(.pathError("missing url"))
        }
        
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = queries.map(toQueryItem)
        
        guard let encodedURL = components?.url else {
            throw GBNetworkError.requestEncodingFailure(.pathError("query encoding fail"))
        }
        return .init(url: encodedURL)
    }
    
    func encode(body: Encodable) throws -> URLRequest {
        do {
            var request = self
            request.httpBody = try JSONEncoder().encode(body)
            return request
        } catch {
            throw GBNetworkError.requestEncodingFailure(.jsonError("incorrect body type"))
        }
    }
}

private extension URLRequest {
    func toQueryItem(_ query: (key: String, value: Any)) -> URLQueryItem {
        .init(name: query.key, value: query.value as? String)
    }
}
