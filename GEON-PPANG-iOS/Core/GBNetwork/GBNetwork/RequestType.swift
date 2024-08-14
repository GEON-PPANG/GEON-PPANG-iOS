//
//  RequestType.swift
//  GBNetwork
//
//  Created by 이성민 on 6/29/24.
//

import Foundation

public protocol RequestType {
    
    /// Request를 보내는 Base URL
    var baseURL: String { get }
    
    /// Base URL 뒤에 붙는 URL Path
    var path: String { get }
    
    /// 실제로 사용하는 HTTP Method만 정의 - Get, Post, Delete
    ///
    /// - Request의 HTTP Method:
    /// 현재는 GET, POST, DELETE만 사용하기 때문에 세 가지만 설정
    ///
    /// - computed property로 한 이유는 encodable에 걸리지 않기 때문
    var method: HTTPMethod { get }
    
    /// 어떤 방식으로 Request를 보낼지에 대한 정보
    ///
    /// - `.requestPlain` - 추가적인 body 또는 query 없이 요청
    /// - `.requestQuery(_ [String: Any])` - url path 뒤에 query 추가하여 요청
    /// - `.requestEncodable(_ : Encodable)` - encodable 한 body와 함께 요청
    var task: HTTPTask { get }
    
    /// Request 마다 필요한 Header Fields
    var headers: HTTPHeader { get }
}

extension RequestType {
    
    func toURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.headers.fields
        
        switch task {
        case .requestPlain:
            return urlRequest
        case let .requestQuery(queries):
            return try urlRequest.encode(queries: queries)
        case let .requestEncodable(body):
            return try urlRequest.encode(body: body)
        }
    }
}
