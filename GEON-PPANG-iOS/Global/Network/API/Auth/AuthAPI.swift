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
    
    var authProvider = MoyaProvider<AuthService>(plugins: [AuthPlugin()])
    
    // MARK: - Post
    
    func postCheckEmail(to emailData: EmailRequestDTO, completion: @escaping (Int?) -> Void) {
        authProvider.request(.checkEmail(request: emailData)) { result in
            switch result {
            case let .success(response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postCheckNickname(to nicknameData: NicknameRequestDTO, completion: @escaping (Int?) -> Void) {
        authProvider.request(.checkNickname(request: nicknameData)) { result in
            switch result {
            case let .success(response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postLogin(to loginData: LoginRequestDTO, completion: @escaping (Int?) -> Void) {
        authProvider.request(.login(request: loginData)) { result in
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
