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
    
    public private(set) var bakeryList: GeneralArrayResponse<BakeryListResponseDTO>?
    public private(set) var writeReview: WriteReviewResponse?
    
    // MARK: - GET
    
    func getBakeryList(sort: String, isHard: Bool, isDessert: Bool, isBrunch: Bool, completion: @escaping (GeneralArrayResponse<BakeryListResponseDTO>?) -> Void) {
        bakeryProvider.request(.bakeryList(sort: sort, isHard: isHard, isDessert: isDessert, isBrunch: isBrunch)) { result in
            switch result {
            case let .success(response):
                do {
                    self.bakeryList = try response.map(GeneralArrayResponse<BakeryListResponseDTO>.self)
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
    
    // MARK: - POST
    
    func writeReview(content: WriteReviewRequest, completion: @escaping (WriteReviewResponse?) -> Void) {
        bakeryProvider.request(.writeReview(bakeryID: 1, content: content)) { result in
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
