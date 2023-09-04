//
//  AuthAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class AuthAPI {
    
    static let shared: AuthAPI = AuthAPI()
    
    private init() {}
    
    var authProvider = MoyaProvider<AuthService>(plugins: [MoyaLoggingPlugin()])
    
    func postCheckEmail(to emailData: EmailRequestDTO, completion: @escaping (Int?) -> Void) {
        authProvider.request(.checkEmail(requestEmail: emailData)) { result in
            switch result {
            case let .success(response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
