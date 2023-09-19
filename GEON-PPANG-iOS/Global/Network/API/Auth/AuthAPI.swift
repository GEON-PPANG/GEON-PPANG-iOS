//
//  AuthAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class AuthAPI {
    
    typealias SignUpResponse = GeneralResponse<SignUpResponseDTO>
    typealias TokenRefreshResponse = GeneralResponse<VoidType>
    typealias DeleteUserResponse = GeneralResponse<DeleteUserResponseDTO>
    
    static let shared: AuthAPI = AuthAPI()
    
    private init() {}
    
    var authProvider = MoyaProvider<AuthService>(plugins: [AuthPlugin()])
    
    public private(set) var signUpResponse: SignUpResponse?
    public private(set) var tokenRefreshResponse: TokenRefreshResponse?
    public private(set) var deleteUserResponse: DeleteUserResponse?
    
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
    
    func postSignUp(with data: SignUpRequestDTO, completion: @escaping (SignUpResponse?) -> Void) {
        
        authProvider.request(.signUp(request: data)) { result in
            switch result {
            case .success(let response):
                do {
                    self.signUpResponse = try response.map(SignUpResponse.self)
                    guard let signUpResponse = self.signUpResponse else { return }
                    completion(signUpResponse)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getTokenRefresh(completion: @escaping (TokenRefreshResponse?) -> Void) {
        
        authProvider.request(.refreshToken) { result in
            switch result {
            case .success(let response):
                do {
                    self.tokenRefreshResponse = try response.map(TokenRefreshResponse.self)
                    guard let tokenRefreshResponse = self.tokenRefreshResponse else { return }
                    completion(tokenRefreshResponse)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func logout(completion: @escaping (Int?) -> Void) {
        
        authProvider.request(.logout) { result in
            switch result {
            case .success(let response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func deleteUser(completion: @escaping (DeleteUserResponse?) -> Void) {
        
        let type = KeychainService.readKeychain(of: .socialType)
        authProvider.request(type == "APPLE" ? .appleWithdraw : .withdraw) { result in
            switch result {
            case .success(let response):
                do {
                    self.deleteUserResponse = try response.map(DeleteUserResponse.self)
                    guard let deleteUserResponse = self.deleteUserResponse else { return }
                    completion(deleteUserResponse)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
