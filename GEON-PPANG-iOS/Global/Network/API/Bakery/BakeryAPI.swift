//
//  BakeryAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class BakeryAPI {
    
    static let shared: BakeryAPI = BakeryAPI()
    
    private init() { }
    
    var bakeryListProvider = MoyaProvider<BakeryService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var bakeryList: GeneralArrayResponse<BakeryListResponseDTO>?
    
    // MARK: - GET
    
    func getBakeryList(sort: String, isHard: Bool, isDessert: Bool, isBrunch: Bool, completion: @escaping (GeneralArrayResponse<BakeryListResponseDTO>?) -> Void) {
        bakeryListProvider.request(.bakeryList(sort: sort, isHard: isHard, isDessert: isDessert, isBrunch: isBrunch)) { result in
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
}
