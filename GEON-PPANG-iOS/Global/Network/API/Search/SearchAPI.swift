//
//  SearchAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class SearchAPI {
    
    static let shared: SearchAPI = SearchAPI()
    
    private init() { }
    
    var searchProvider = MoyaProvider<SearchService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var searchBakery: GeneralResponse<SearchResponseDTO>?
    
    // MARK: - GET
    
    func searchBakeryList(bakeryID: String, completion: @escaping (GeneralResponse<SearchResponseDTO>?) -> Void) {
        searchProvider.request(.searchBakery(bakeryID: bakeryID)) { result in
            switch result {
            case let .success(response):
                do {
                    self.searchBakery = try response.map(GeneralResponse<SearchResponseDTO>.self)
                    guard let searchBakery = self.searchBakery else { return }

                    completion(searchBakery)
                    print("✅\(searchBakery)")
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
