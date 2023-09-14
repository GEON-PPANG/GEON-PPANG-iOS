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
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard request.response?.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        AuthAPI.shared.getTokenRefresh { status in
            switch status {
            case 200:
                print("갱신 성공")
            default:
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootViewControllerToOnboardingViewController()
            }
        }
    }
}
