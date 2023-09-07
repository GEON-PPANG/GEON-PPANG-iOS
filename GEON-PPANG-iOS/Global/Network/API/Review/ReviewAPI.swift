//
//  ReviewAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/07.
//

import UIKit

import Moya

final class ReviewAPI {
    
    typealias WriteReviewRequest = WriteReviewRequestDTO
    typealias WriteReviewResponse = GeneralResponse<VoidType>
    typealias MyReviewDetailResponse = GeneralResponse<MyReviewDetailResponseDTO>
    
    static let shared: ReviewAPI = ReviewAPI()
    
    private init() {}
    
    var reviewProvider = MoyaProvider<ReviewService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var writeReview: WriteReviewResponse?
    public private(set) var myReviewDetail: MyReviewDetailResponse?
    
    // MARK: - request func
    
    func postWriteReview(content: WriteReviewRequest, completion: @escaping (WriteReviewResponse?) -> Void) {
        reviewProvider.request(.writeReview(bakeryID: content.bakeryID, content: content)) { result in
            switch result {
            case let .success(response):
                do {
                    self.writeReview = try response.map(WriteReviewResponse.self)
                    guard let writeReview = self.writeReview else { return }
                    
                    completion(writeReview)
                    print("✅\(writeReview)")
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getMyReviewDetail(of id: Int, completion: @escaping(MyReviewDetailResponse?) -> Void) {
        reviewProvider.request(.fetchMyReviewDetail(reviewID: id)) { result in
            switch result {
            case let .success(response):
                do {
                    self.myReviewDetail = try response.map(MyReviewDetailResponse.self)
                    guard let myReviewDetail = self.myReviewDetail else { return }
                    
                    completion(myReviewDetail)
                    print("✅\(myReviewDetail)")
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
