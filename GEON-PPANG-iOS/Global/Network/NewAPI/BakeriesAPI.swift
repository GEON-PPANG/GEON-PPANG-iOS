//
//  BakeriesAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

typealias BakeryRequest = BakeryRequestDTO
typealias BakeriesResponse = GeneralArrayResponse<BakeryCommonListResponseDTO>
typealias BakeryDetailResponse = GeneralResponse<BakeryDetailResponseDTO>
typealias BakeryReviewsResponse = GeneralResponse<WrittenReviewsResponseDTO>

protocol BakeriesAPIType {
    func getBakeries(parameters: BakeryRequestDTO, completion: @escaping (BakeriesResponse?) -> Void)
    func getBakeryDetail(bakeryID: Int, completion: @escaping (BakeryDetailResponse?) -> Void)
    func getBakeryReviews(bakeryID: Int, completion: @escaping (BakeryReviewsResponse?) -> Void)
}

final class BakeriesAPI: BakeriesAPIType {
    
    static let shared: BakeriesAPI = BakeriesAPI()
    private init() {}
    
    var provider: MoyaProvider<BakeriesService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                               plugins: [MoyaLoggingPlugin()])
    
    func getBakeries(parameters: BakeryRequestDTO, completion: @escaping (BakeriesResponse?) -> Void) {
        provider.request(.bakeries(parameters: parameters)) { result in
            switch result {
            case let .success(response):
                do {
                    let bakeries = try response.map(BakeriesResponse.self)
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
    
    func getBakeryDetail(bakeryID: Int, completion: @escaping (BakeryDetailResponse?) -> Void) {
        provider.request(.bakeryDetail(bakeryID: bakeryID)) { result in
            switch result {
            case let .success(response):
                do {
                    let bakeryDetail = try response.map(BakeryDetailResponse.self)
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
    
    func getBakeryReviews(bakeryID: Int, completion: @escaping (BakeryReviewsResponse?) -> Void) {
        provider.request(.bakeryReviews(bakeryID: bakeryID)) { result in
            switch result {
            case let .success(response):
                do {
                    let reviews = try response.map(GeneralResponse<WrittenReviewsResponseDTO>.self)
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
