//
//  HomeAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class HomeAPI {
    
    static let shared: HomeAPI = HomeAPI()
    
    private init() { }
    
    var homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var bestReviews: GeneralArrayResponse<HomeBestBakeryResponseDTO>?
    
    // MARK: - GET
    
    func getBestReviews(completion: @escaping (GeneralArrayResponse<HomeBestBakeryResponseDTO>?) -> Void) {
        homeProvider.request(.best) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(GeneralArrayResponse<HomeBestBakeryResponseDTO>.self)
                    completion(data)
                    print("✅\(data)")
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
