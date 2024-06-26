//
//  AuthInterceptor.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/14.
//

import Foundation
import UIKit

import Alamofire
import Moya

final class AuthInterceptor: RequestInterceptor {
    
    static let shared = AuthInterceptor()
    
    private init() {}
    
    // MARK: - Conforming methods
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Config.baseURL) == true
        else {
            completion(.success(urlRequest))
            return
        }
        
        guard KeychainService.readKeychain(of: .role) == UserRole.member.rawValue
        else {
            completion(.success(urlRequest))
            return
        }
        
        let authorization = KeychainService.readKeychain(of: .access)
        var urlRequest = urlRequest
        
        urlRequest.headers.add(.authorization(bearerToken: authorization))
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard KeychainService.readKeychain(of: .role) == UserRole.member.rawValue
        else { return }
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetry)
            return
        }
        
        guard request.retryCount < 2
        else {
            DispatchQueue.main.async {
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
            }
            return
        }
        
        AuthAPI.shared.getTokenRefresh { response in
            guard let response = response else { return }
            
            if response == 200 {
                completion(.retry)
            } else {
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
                completion(.doNotRetry)
            }
        }
    }
}
