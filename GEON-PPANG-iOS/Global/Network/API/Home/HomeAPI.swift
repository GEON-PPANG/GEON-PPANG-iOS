//
//  HomeAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class HomeAPI {
    
    typealias HomeBestBakeryResponse = GeneralArrayResponse<HomeBestBakeryResponseDTO>
    typealias HomeBestReviewResponse = GeneralArrayResponse<HomeBestReviewResponseDTO>
    
    static let shared: HomeAPI = HomeAPI()
    
    private init() {}
    
    var homeProvider = MoyaProvider<HomeService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggingPlugin()])
    
    public private(set) var bestBakery: HomeBestBakeryResponse?
    public private(set) var bestReviews: HomeBestReviewResponse?
    
    // MARK: - GET
    
    func getBestBakery(completion: @escaping (HomeBestBakeryResponse?) -> Void) {
        homeProvider.request(.bestBakery) { result in
            switch result {
            case let .success(response):
                do {
                    self.bestBakery = try
                    response.map(HomeBestBakeryResponse.self)
                    guard let bestBakery = self.bestBakery else { return }
                    completion(bestBakery)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getBestReviews(completion: @escaping (HomeBestReviewResponse?) -> Void) {
        homeProvider.request(.bestReviews) { result in
            switch result {
            case let .success(response):
                do {
                    self.bestReviews = try
                    response.map(HomeBestReviewResponse.self)
                    guard let bestReviews = self.bestReviews else { return }
                    completion(bestReviews)
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
