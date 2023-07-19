//
//  MyPageAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class MyPageAPI {
    
    static let shared: MyPageAPI = MyPageAPI()
    
    private init() { }
    
    var MyPageProvider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var bookmarks: GeneralArrayResponse<BakeryListResponseDTO>?
    
    // MARK: - GET
    
    func getBookmarks(completion: @escaping (GeneralArrayResponse<BakeryListResponseDTO>?) -> Void) {
        MyPageProvider.request(.bookmarks) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(GeneralArrayResponse<BakeryListResponseDTO>.self)
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
