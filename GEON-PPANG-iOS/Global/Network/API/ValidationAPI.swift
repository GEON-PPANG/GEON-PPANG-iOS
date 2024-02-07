//
//  ValidationAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol ValidationAPIType {
    func postCheckEmail(request: EmailRequestDTO, completion: @escaping (Int?) -> Void)
    func postCheckNickname(request: NicknameRequestDTO, completion: @escaping (Int?) -> Void)
}

final class ValidationAPI: ValidationAPIType {
    
    static let shared: ValidationAPI = ValidationAPI()
    private init() {}
    
    var provider: MoyaProvider<ValidationService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                                 plugins: [MoyaLoggingPlugin()])
    
    func postCheckEmail(request: EmailRequestDTO, completion: @escaping (Int?) -> Void) {
        provider.request(.checkEmail(request: request)) { result in
            switch result {
            case let .success(response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postCheckNickname(request: NicknameRequestDTO, completion: @escaping (Int?) -> Void) {
        provider.request(.checkNickname(request: request)) { result in
            switch result {
            case let .success(response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(err.response?.statusCode)
            }
        }
    }
}
