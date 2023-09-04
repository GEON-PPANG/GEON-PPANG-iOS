//
//  FilterAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class FilterAPI {
    
    typealias FilterResponse = GeneralArrayResponse<FilterResponseDTO>
    typealias FilterTypeResponse = GeneralResponse<FilterResponseDTO>
    
    static let shared: FilterAPI = FilterAPI()
    
    private init() {}
    
    var filterProvider = MoyaProvider<FilterService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var response: FilterResponse?
    public private(set) var filterTypeResponse: FilterTypeResponse?
    
    // MARK: - POST
    
    func changeFilter(to filterData: FilterRequestDTO, completion: @escaping (FilterResponse?) -> Void) {
        filterProvider.request(.changeFilter(filterData)) { result in
            switch result {
            case let .success(response):
                do {
                    self.response = try response.map(FilterResponse.self)
                    guard let response = self.response else { return }
                    
                    completion(response)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - GET
    
    func getFilterType(completion: @escaping (FilterTypeResponse?) -> Void) {
        filterProvider.request(.getFilterType) { result in
            switch result {
            case let .success(response):
                do {
                    self.filterTypeResponse = try
                    response.map(FilterTypeResponse.self)
                    guard let filterTypeResponse = self.filterTypeResponse else { return }
                    completion(filterTypeResponse)
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

