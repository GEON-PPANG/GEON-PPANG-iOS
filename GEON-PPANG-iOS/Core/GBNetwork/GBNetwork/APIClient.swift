//
//  APIClient.swift
//  GBNetwork
//
//  Created by 이성민 on 6/29/24.
//

import Foundation

public final class APIClient<Request: RequestType> {
    
    public init() {}
    
    public func send(
        _ request: Request
    ) async throws -> RawResponse {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let (data, urlResponse) = try await session.data(for: request.toURLRequest())
        
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw GBNetworkError.decodingFailure(.httpDecodingError)
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return .init(data: data, httpResponse: httpResponse)
        case 400..<500:
            throw GBNetworkError.responseFailure(.clientError(httpResponse))
        case 500..<600:
            throw GBNetworkError.responseFailure(.serverError(httpResponse))
        default:
            throw GBNetworkError.responseFailure(.invalidError(httpResponse))
        }
    }
}
