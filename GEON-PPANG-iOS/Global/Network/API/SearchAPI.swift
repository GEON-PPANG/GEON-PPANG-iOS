//
//  SearchAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol SearchAPIType {
    func getBakeries(name: String, completion: @escaping (Endpoint<SearchResponseDTO>?) -> Void)
}

final class SearchAPI: SearchAPIType {
    
    static let shared: SearchAPI = SearchAPI()
    private init() {}
    
    var provider: MoyaProvider<SearchService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                             plugins: [MoyaLoggingPlugin()])
    
    func getBakeries(name: String, completion: @escaping (Endpoint<SearchResponseDTO>?) -> Void) {
        provider.request(.bakeries(bakeryName: name)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<SearchResponseDTO>.self)
                    completion(response)
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
