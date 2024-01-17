//
//  BestAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol BestAPIType {
    func getBestBakery(completion: @escaping (ArrayEndpoint<HomeBestBakeryResponseDTO>?) -> Void)
    func getBestReviews(completion: @escaping (ArrayEndpoint<HomeBestReviewResponseDTO>?) -> Void)
}
final class BestAPI: BestAPIType {
    
    static let shared: BestAPI = BestAPI()
    
    private init() {}
    
    var provider = MoyaProvider<BestService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggingPlugin()])
    
    // MARK: - GET
    
    func getBestBakery(completion: @escaping (ArrayEndpoint<HomeBestBakeryResponseDTO>?) -> Void) {
        provider.request(.bakery) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try
                    response.map(ArrayEndpoint<HomeBestBakeryResponseDTO>.self)
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
    
    func getBestReviews(completion: @escaping (ArrayEndpoint<HomeBestReviewResponseDTO>?) -> Void) {
        provider.request(.reviews) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try
                    response.map(ArrayEndpoint<HomeBestReviewResponseDTO>.self)
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
