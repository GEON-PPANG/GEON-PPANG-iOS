//
//  LoginProtocol.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/30/24.
//

import UIKit

protocol LoginProtocol {
    func postSignUp(with request: SignUpRequestDTO, viewController: UIViewController, completion: ((String) -> Void)?)
    func getNickname(_ completion: @escaping (String?, Int?) -> Void)
}

extension LoginProtocol {
    
    func postSignUp(with request: SignUpRequestDTO, viewController: UIViewController, completion: ((String) -> Void)?) {
        
        AuthAPI.shared.postSignUp(request: request) { status in
            
            guard let code = status?.code else { return }
            switch code {
            case 200...299:
                guard let userID = status?.data?.memberID,
                      let role = status?.data?.role
                else { return }
                AnalyticManager.set(userId: userID)
                completion?(role)
            default:
                Utils.showAlert(title: "에러", description: "실패", at: viewController)
            }
        }
    }
    
    func getNickname(_ completion: @escaping (String?, Int?) -> Void) {
        
        MemberAPI.shared.getNickname { result, err in
            
            if err == 403 { completion(nil, err); return }
            
            guard let result = result,
                  let response = result.data
            else { completion(nil, nil); return }
            
            switch result.code {
            case 200:
                completion(response.nickname, nil)
            default:
                completion(nil, nil)
            }
        }
    }
}
