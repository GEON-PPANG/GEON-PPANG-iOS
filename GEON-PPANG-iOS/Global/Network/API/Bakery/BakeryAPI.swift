//
//  BakeryAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class BakeryAPI {
    
    typealias WriteReviewResponse = GeneralResponse<WriteReviewDTO>
    
    static let shared: BakeryAPI = BakeryAPI()
    
    private init() {}
    
    var bakeryProvider = MoyaProvider<BakeryService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var writeReview: WriteReviewResponse?
    
    // MARK: - POST
    
    func writeReview(bakeryID: String, completion: @escaping (WriteReviewResponse?) -> Void) {
        bakeryProvider.request(.writeReview(bakeryID: bakeryID)) { result in
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
}
