//
//  BakeryAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class BakeryAPI {
    
    typealias WriteReviewRequest = WriteReviewDTO
    typealias WriteReviewResponse = GeneralResponse<VoidType>
    
    static let shared: BakeryAPI = BakeryAPI()
    
    private init() {}
    
    var bakeryProvider = MoyaProvider<BakeryService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var writeReview: WriteReviewResponse?
    
    // MARK: - POST
    
    func writeReview(content: WriteReviewRequest, completion: @escaping (WriteReviewResponse?) -> Void) {
        bakeryProvider.request(.writeReview(content: content)) { result in
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
