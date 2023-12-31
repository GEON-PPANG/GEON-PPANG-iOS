//
//  BakeryAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class BakeryAPI {
    
    typealias WriteReviewRequest = WriteReviewRequestDTO
    typealias WriteReviewResponse = GeneralResponse<VoidType>
    typealias BookmarkResponse = GeneralResponse<BookmarkResponseDTO>
    
    static let shared: BakeryAPI = BakeryAPI()
    
    private init() {}
    
    var bakeryProvider = MoyaProvider<BakeryService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggingPlugin()])
    
    public private(set) var bakeryList: GeneralArrayResponse<BakeryCommonListResponseDTO>?
    public private(set) var writeReview: WriteReviewResponse?
    public private(set) var bakeryDetail: GeneralResponse<BakeryDetailResponseDTO>?
    public private(set) var writtenReviews: GeneralResponse<WrittenReviewsResponseDTO>?
    public private(set) var bookmark: BookmarkResponse?
    
    // MARK: - GET
    
    func getBakeryList(to request: BakeryRequestDTO, completion: @escaping (GeneralArrayResponse<BakeryCommonListResponseDTO>?) -> Void) {
        bakeryProvider.request(.bakeryList(request: request)) { result in
            switch result {
            case let .success(response):
                do {
                    self.bakeryList = try response.map(GeneralArrayResponse<BakeryCommonListResponseDTO>.self)
                    guard let bakeryList = self.bakeryList else { return }
                    completion(bakeryList)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getBakeryDetail(bakeryID: Int, completion: @escaping (GeneralResponse<BakeryDetailResponseDTO>?) -> Void) {
        bakeryProvider.request(.fetchBakeryDetail(bakeryID: bakeryID)) { result in
            switch result {
            case let .success(response):
                do {
                    self.bakeryDetail = try response.map(GeneralResponse<BakeryDetailResponseDTO>.self)
                    guard let bakeryDetail = self.bakeryDetail else { return }
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
    
    func getWrittenReviews(bakeryID: Int, completion: @escaping (GeneralResponse<WrittenReviewsResponseDTO>?) -> Void) {
        bakeryProvider.request(.fetchWrittenReviews(bakeryID: bakeryID)) { result in
            switch result {
            case let .success(response):
                do {
                    self.writtenReviews = try response.map(GeneralResponse<WrittenReviewsResponseDTO>.self)
                    guard let writtenReviews = self.writtenReviews else { return }
                    completion(writtenReviews)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postBookmark(bakeryID: Int, with request: BookmarkRequestDTO, completion: @escaping (BookmarkResponse?) -> Void) {
        bakeryProvider.request(.bookmark(bakeryID: bakeryID, request: request)) { result in
            switch result {
            case let .success(response):
                do {
                    self.bookmark = try response.map(BookmarkResponse.self)
                    guard let bookmark = self.bookmark else { return }
                    
                    completion(bookmark)
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
