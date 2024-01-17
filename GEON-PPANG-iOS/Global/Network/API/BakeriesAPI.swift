//
//  BakeriesAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol BakeriesAPIType {
    func getBakeries(parameters: BakeryRequestDTO, completion: @escaping (ArrayEndpoint<BakeryCommonListResponseDTO>?) -> Void)
    func getBakeryDetail(bakeryID: Int, completion: @escaping (Endpoint<BakeryDetailResponseDTO>?) -> Void)
    func getBakeryReviews(bakeryID: Int, completion: @escaping (Endpoint<WrittenReviewsResponseDTO>?) -> Void)
}

final class BakeriesAPI: BakeriesAPIType {
    
    static let shared: BakeriesAPI = BakeriesAPI()
    private init() {}
    
    var provider: MoyaProvider<BakeriesService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                               plugins: [MoyaLoggingPlugin()])
    
    func getBakeries(parameters: BakeryRequestDTO, completion: @escaping (ArrayEndpoint<BakeryCommonListResponseDTO>?) -> Void) {
        provider.request(.bakeries(parameters: parameters)) { result in
            switch result {
            case let .success(response):
                do {
                    let bakeries = try response.map(ArrayEndpoint<BakeryCommonListResponseDTO>.self)
                    completion(bakeries)
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getBakeryDetail(bakeryID: Int, completion: @escaping (Endpoint<BakeryDetailResponseDTO>?) -> Void) {
        provider.request(.bakeryDetail(bakeryID: bakeryID)) { result in
            switch result {
            case let .success(response):
                do {
                    let bakeryDetail = try response.map(Endpoint<BakeryDetailResponseDTO>.self)
                    completion(bakeryDetail)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getBakeryReviews(bakeryID: Int, completion: @escaping (Endpoint<WrittenReviewsResponseDTO>?) -> Void) {
        provider.request(.bakeryReviews(bakeryID: bakeryID)) { result in
            switch result {
            case let .success(response):
                do {
                    let reviews = try response.map(Endpoint<WrittenReviewsResponseDTO> .self)
                    completion(reviews)
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
