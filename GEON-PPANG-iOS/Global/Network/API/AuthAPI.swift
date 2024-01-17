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
    func postSignUp(request: SignUpRequestDTO, completion: @escaping (Endpoint<SignUpResponseDTO>?) -> Void)
    func getTokenRefresh(completion: @escaping (Endpoint<VoidType>?) -> Void)
    func logout(completion: @escaping (Int?) -> Void)
    func deleteUser(completion: @escaping (Endpoint<DeleteUserResponseDTO>?) -> Void)
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
                    let response = try response.map(Endpoint<SearchResponseDTO>.self)
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
    
    func postSignUp(request: SignUpRequestDTO, completion: @escaping (Endpoint<SignUpResponseDTO>?) -> Void) {
        defaultProvider.request(.signUp(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<SignUpResponseDTO>.self)
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
    
    func getTokenRefresh(completion: @escaping (Endpoint<VoidType>?) -> Void) {
        defaultProvider.request(.refreshToken) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<VoidType>.self)
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
    
    func deleteUser(completion: @escaping (Endpoint<DeleteUserResponseDTO>?) -> Void) {
        let type = KeychainService.readKeychain(of: .socialType)
        tokenProvider.request(type == "APPLE" ? .appleWithdraw : .withdraw) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<DeleteUserResponseDTO>.self)
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
