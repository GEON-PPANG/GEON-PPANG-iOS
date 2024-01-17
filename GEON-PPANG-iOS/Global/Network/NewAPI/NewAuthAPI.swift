//
//  AuthAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol AuthAPIType {
    func postLogin(request: LoginRequestDTO, completion: @escaping (Int?) -> Void)
    func postSignUp(request: SignUpRequestDTO, completion: @escaping (EndPoint<SignUpResponseDTO>?) -> Void)
    func getTokenRefresh(completion: @escaping (EndPoint<VoidType>?) -> Void)
    func logout(completion: @escaping (Int?) -> Void)
    func deleteUser(completion: @escaping (EndPoint<DeleteUserResponseDTO>?) -> Void)
}

final class AuthAPI: AuthAPIType {
    
    static let shared: AuthAPI = AuthAPI()
    private init() {}
    
    var defaultProvider: MoyaProvider<AuthService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                                  plugins: [MoyaLoggingPlugin()])
    
    var tokenProvider : MoyaProvider<AuthService> = MoyaProvider<AuthService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [AuthPlugin()])
    
    func postLogin(request: LoginRequestDTO, completion: @escaping (Int?) -> Void) {
        defaultProvider.request(.login(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(EndPoint<SearchResponseDTO>.self)
                    completion(response.code)
                } catch let err {
                    print(err.localizedDescription)
                }
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postSignUp(request: SignUpRequestDTO, completion: @escaping (EndPoint<SignUpResponseDTO>?) -> Void) {
        defaultProvider.request(.signUp(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(EndPoint<SignUpResponseDTO>.self)
                    completion(response)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getTokenRefresh(completion: @escaping (EndPoint<VoidType>?) -> Void) {
        defaultProvider.request(.refreshToken) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(EndPoint<VoidType>.self)
                    completion(response)
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
        tokenProvider.request(.logout) { result in
            switch result {
            case .success(let response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func deleteUser(completion: @escaping (EndPoint<DeleteUserResponseDTO>?) -> Void) {
        let type = KeychainService.readKeychain(of: .socialType)
        tokenProvider.request(type == "APPLE" ? .appleWithdraw : .withdraw) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(EndPoint<DeleteUserResponseDTO>.self)
                    completion(response)
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
