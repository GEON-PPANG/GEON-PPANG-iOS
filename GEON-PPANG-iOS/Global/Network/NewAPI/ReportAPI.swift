//
//  ReportAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

protocol ReportAPIType {
    func postWriteReport(reviewID: Int, request: ReportRequestDTO, completion: @escaping (Endpoint<ReportResponseDTO>?) -> Void)
}

final class ReportAPI: ReportAPIType {
    
    static let shared: ReportAPI = ReportAPI()
    private init() {}
    
    var provider = MoyaProvider<ReportService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggingPlugin()])
    
    func postWriteReport(reviewID: Int, request: ReportRequestDTO, completion: @escaping (Endpoint<ReportResponseDTO>?) -> Void) {
        
        provider.request(.writeReport(reviewID: reviewID, request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Endpoint<ReportResponseDTO>.self)
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
}
