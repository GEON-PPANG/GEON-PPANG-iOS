//
//  ReportAPI.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/09/29.
//

import Foundation

import Moya

final class ReportAPI {
    
    typealias WriteReportResponse = GeneralResponse<ReportResponseDTO>
    
    static let shared = ReportAPI()
    
    private init() {}
    
    var reportProvider = MoyaProvider<ReportService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggingPlugin()])
    
    public private(set) var writeReportResponse: WriteReportResponse?
    
    func postWriteReport(reviewID: Int, content: ReportRequestDTO, completion: @escaping (WriteReportResponse?) -> Void) {
        
        reportProvider.request(.writeReport(reviewID: reviewID, content: content)) { result in
            switch result {
            case .success(let response):
                do {
                    self.writeReportResponse = try response.map(WriteReportResponse.self)
                    guard let response = self.writeReportResponse else { return }
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
