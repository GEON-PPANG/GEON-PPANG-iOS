//
//  GBNetworkError.swift
//  GBNetwork
//
//  Created by 이성민 on 6/29/24.
//

import Foundation

public enum GBNetworkError: Error {
    
    // MARK: - Request related errors
    
    /// Creating `URL` from `String` failure
    case urlCreationFailure(urlString: String)
    
    /// Encoding  to `URLRequest` failure
    case requestEncodingFailure(EncodingFailureReason)
    
    // MARK: - Response related errors
    
    /// Failure received from response
    case responseFailure(ResponseFailureReason)
    
    /// Decoding `Data` to response type failure
    case decodingFailure(DecodingFailureReason)
    
    /// Failure other than the failures above
    case unknownFailure(description: String)
}


public extension GBNetworkError {
    
    enum EncodingFailureReason {
        case pathError(String)
        case jsonError(String)
    }
    
    /// detailed reason why `.responseFailure` occurred
    enum ResponseFailureReason {
        case clientError(HTTPURLResponse)
        case serverError(HTTPURLResponse)
        case invalidError(HTTPURLResponse)
    }
    
    enum DecodingFailureReason {
        case httpDecodingError
        case dtoDecodingError
    }
}

