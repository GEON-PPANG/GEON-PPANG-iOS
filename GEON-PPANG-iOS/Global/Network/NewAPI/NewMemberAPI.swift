//
//  MemberAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

typealias PostFilterRequest = FilterRequestDTO
typealias PostFilterResponse = GeneralArrayResponse<FilterResponseDTO>
typealias GetFilterResponse = GeneralResponse<FilterResponseDTO>
typealias PostNicknameRequest = NicknameRequestDTO
typealias PostNicknameResponse = GeneralResponse<SetNicknameResponseDTO>
typealias GetNicknameResponse = GeneralResponse<FetchNicknameResponseDTO>
typealias BookmarkResponse = GeneralResponse<BookmarkResponseDTO>
typealias ReviewsResponse = GeneralArrayResponse<MyReviewsResponseDTO>
typealias MemberResponse = GeneralResponse<MyPageResponseDTO>

protocol MemberAPIType {
    func postFilter(request: PostFilterRequest, completion: @escaping (PostFilterResponse?) -> Void)
    func getFilter(completion: @escaping (GetFilterResponse?) -> Void)
    func postNickname(request: PostNicknameRequest, completion: @escaping (PostNicknameResponse?) -> Void)
    func getNickname(completion: @escaping (GetNicknameResponse?) -> Void)
    func bookmarks(completion: @escaping (BookmarkResponse?) -> Void)
    func reviews(completion: @escaping (ReviewsResponse?) -> Void)
    func member(completion: @escaping (MemberResponse?) -> Void)
}

final class MemberAPI: MemberAPIType {
    
    static let shared: MemberAPI = MemberAPI()
    private init() {}
    
    var provider: MoyaProvider<MemberService> = MoyaProvider(session: Session(interceptor: AuthInterceptor.shared),
                                                             plugins: [MoyaLoggingPlugin()])
    
    func postFilter(request: PostFilterRequest, completion: @escaping (PostFilterResponse?) -> Void) {
        provider.request(.postTypes(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(PostFilterResponse.self)
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
    
    func getFilter(completion: @escaping (GetFilterResponse?) -> Void) {
        provider.request(.getTypes) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(GetFilterResponse.self)
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
    
    func postNickname(request: PostNicknameRequest, completion: @escaping (PostNicknameResponse?) -> Void) {
        provider.request(.postNickname(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(PostNicknameResponse.self)
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
    
    func getNickname(completion: @escaping (GetNicknameResponse?) -> Void) {
        provider.request(.getNickname) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(GetNicknameResponse.self)
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
    
    func bookmarks(completion: @escaping (BookmarkResponse?) -> Void) {
        provider.request(.bookmarks) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(BookmarkResponse.self)
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
    
    func reviews(completion: @escaping (ReviewsResponse?) -> Void) {
        provider.request(.reviews) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(ReviewsResponse.self)
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
    
    func member(completion: @escaping (MemberResponse?) -> Void) {
        provider.request(.member) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(MemberResponse.self)
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
