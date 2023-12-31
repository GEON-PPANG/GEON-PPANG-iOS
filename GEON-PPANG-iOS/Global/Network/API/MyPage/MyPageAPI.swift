//
//  MyPageAPI.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

final class MyPageAPI {
    
    typealias Bookmarks = GeneralArrayResponse<BakeryCommonListResponseDTO>
    typealias Myreviews = GeneralArrayResponse<MyReviewsResponseDTO>
    
    typealias MemberDataResponse = GeneralResponse<MyPageResponseDTO>
    
    static let shared: MyPageAPI = MyPageAPI()
    
    private init() { }
    
    var MyPageProvider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
    
    public private(set) var bookmarks: Bookmarks?
    public private(set) var myReviews: Myreviews?
    
    // MARK: - GET
    
    func getMemberData(completion: @escaping (MemberDataResponse?) -> Void) {
        MyPageProvider.request(.memberData) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(MemberDataResponse.self)
                    completion(data)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getBookmarks(completion: @escaping (Bookmarks?) -> Void) {
        MyPageProvider.request(.bookmarks) { result in
            switch result {
            case let .success(response):
                do {
                    self.bookmarks = try
                    response.map(Bookmarks.self)
                    guard let bookmarks = self.bookmarks else { return }
                    completion(bookmarks)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getMyReviews(completion: @escaping (Myreviews?) -> Void) {
        MyPageProvider.request(.myReviews) { result in
            switch result {
            case let .success(response):
                do {
                    self.myReviews = try
                    response.map(Myreviews.self)
                    guard let myReviews = self.myReviews else { return }
                    completion(myReviews)
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
