//
//  MemberAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol MemberAPIType {
    func postFilter(request: FilterRequestDTO, completion: @escaping (ArrayEndpoint<FilterResponseDTO>?) -> Void)
    func getFilter(completion: @escaping (Endpoint<FilterResponseDTO>?) -> Void)
    func postNickname(request: NicknameRequestDTO, completion: @escaping (Endpoint<SetNicknameResponseDTO>?) -> Void)
    func getNickname(completion: @escaping (Endpoint<FetchNicknameResponseDTO>?, Int?) -> Void)
    func bookmarks(completion: @escaping (ArrayEndpoint<BookmarkBakeryListResponseDTO>?) -> Void)
    func reviews(completion: @escaping (ArrayEndpoint<MyReviewsResponseDTO>?) -> Void)
    func member(completion: @escaping (Endpoint<MyPageResponseDTO>?) -> Void)
}

final class MemberAPI: MemberAPIType {
    
    static let shared: MemberAPI = MemberAPI()
    private init() {}
    
    var provider: MoyaProvider<MemberService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                             plugins: [MoyaLoggingPlugin()])
    
    func postFilter(request: FilterRequestDTO, completion: @escaping (ArrayEndpoint<FilterResponseDTO>?) -> Void) {
        provider.request(.postTypes(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(ArrayEndpoint<FilterResponseDTO>.self)
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
    
    func getFilter(completion: @escaping (Endpoint<FilterResponseDTO>?) -> Void) {
        provider.request(.getTypes) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<FilterResponseDTO>.self)
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
    
    func postNickname(request: NicknameRequestDTO, completion: @escaping (Endpoint<SetNicknameResponseDTO>?) -> Void) {
        provider.request(.postNickname(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<SetNicknameResponseDTO>.self)
                    completion(response)
                } catch let err {
                    print(err)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getNickname(completion: @escaping (Endpoint<FetchNicknameResponseDTO>?, Int?) -> Void) {
        provider.request(.getNickname) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<FetchNicknameResponseDTO>.self)
                    completion(response, nil)
                } catch _ {
                    completion(nil, nil)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err.response?.statusCode)
            }
        }
    }
    
    func bookmarks(completion: @escaping (ArrayEndpoint<BookmarkBakeryListResponseDTO>?) -> Void) {
        provider.request(.bookmarks) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(ArrayEndpoint<BookmarkBakeryListResponseDTO>.self)
                    completion(response)
                } catch let err {
                    print(err)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func reviews(completion: @escaping (ArrayEndpoint<MyReviewsResponseDTO>?) -> Void) {
        provider.request(.reviews) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(ArrayEndpoint<MyReviewsResponseDTO>.self)
                    completion(response)
                } catch let err {
                    print(err)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func member(completion: @escaping (Endpoint<MyPageResponseDTO>?) -> Void) {
        provider.request(.member) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<MyPageResponseDTO>.self)
                    completion(response)
                } catch let err {
                    print(err)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
