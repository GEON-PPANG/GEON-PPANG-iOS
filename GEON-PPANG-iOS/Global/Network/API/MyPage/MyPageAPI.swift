//
//  MyPageAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class MyPageAPI {
    
    typealias Bookmarks = GeneralArrayResponse<BakeryListResponseDTO>
  //  typealias Myreviews = GeneralArrayResponse<m
    
    static let shared: MyPageAPI = MyPageAPI()
    
    private init() { }
    
    var MyPageProvider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var bookmarks: Bookmarks?
    
    // MARK: - GET
    
    func getBookmarks(completion: @escaping (Bookmarks?) -> Void) {
        MyPageProvider.request(.bookmarks) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(Bookmarks.self)
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
