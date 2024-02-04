//
//  ReviewsAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol ReviewsAPIType {
    func postWriteReview(content: WriteReviewRequestDTO, completion: @escaping (Endpoint<VoidType>?) -> Void)
    func getMyReview(id: Int, completion: @escaping (Endpoint<MyReviewDetailResponseDTO>?) -> Void)
}

final class ReviewsAPI: ReviewsAPIType {
    
    static let shared: ReviewsAPI = ReviewsAPI()
    private init() {}
    
    var provider: MoyaProvider<ReviewsService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                              plugins: [MoyaLoggingPlugin()])
    
    func postWriteReview(content: WriteReviewRequestDTO, completion: @escaping (Endpoint<VoidType>?) -> Void) {
        provider.request(.write(bakeryID: content.bakeryID, content: content)) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(Endpoint<VoidType>.self)
                    completion(response)
                    
                    #if DEBUG
                    print("✅\(response)")
                    #endif
                } catch let err {
                    print(err.localizedDescription)
                    completion(nil)
                }
            case let .failure(err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getMyReview(id: Int, completion: @escaping (Endpoint<MyReviewDetailResponseDTO>?) -> Void) {
        provider.request(.myReview(reviewID: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(Endpoint<MyReviewDetailResponseDTO>.self)
                    completion(response)
                    
                    #if DEBUG
                    print("✅\(response)")
                    #endif
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
