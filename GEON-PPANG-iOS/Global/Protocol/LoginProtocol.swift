//
//  LoginProtocol.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/30/24.
//

import UIKit

protocol LoginProtocol {
    func postSignUp(with request: SignUpRequestDTO, viewController: UIViewController, completion: (() -> Void)?)
    func getNickname(_ completion: @escaping (String?) -> Void)
}

extension LoginProtocol {
    
    func postSignUp(with request: SignUpRequestDTO, viewController: UIViewController, completion: (() -> Void)?) {
        
        AuthAPI.shared.postSignUp(request: request) { status in
            
            guard let code = status?.code else { return }
            switch code {
            case 200...299:
                guard let userID = status?.data?.memberID else { return }
                AnalyticManager.set(userId: userID)
                completion?()
            default:
                Utils.showAlert(title: "에러", description: "실패", at: viewController)
            }
        }
    }
    
    func getNickname(_ completion: @escaping (String?) -> Void) {
        
        MemberAPI.shared.getNickname { result in
            guard let result = result,
                  let response = result.data
            else { return }
            switch result.code {
            case 200:
                completion(response.nickname)
            default:
                completion(nil)
            }
        }
    }
}
