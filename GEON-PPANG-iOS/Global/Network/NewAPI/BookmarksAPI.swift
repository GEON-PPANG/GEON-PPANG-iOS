//
//  BookmarksAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol BookmarksAPIType {
    func bookmark(id: Int, request: BookmarkRequestDTO, completion: @escaping (Endpoint<BookmarkResponseDTO>?) -> Void)
}

final class BookmarksAPI: BookmarksAPIType {
    
    static let shared: BookmarksAPI = BookmarksAPI()
    private init() {}
    
    var provider: MoyaProvider<BookmarksService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                                plugins: [MoyaLoggingPlugin()])
    
    func bookmark(id: Int, request: BookmarkRequestDTO, completion: @escaping (Endpoint<BookmarkResponseDTO>?) -> Void) {
        provider.request(.bookmark(bakeryID: id, request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<BookmarkResponseDTO>.self)
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
