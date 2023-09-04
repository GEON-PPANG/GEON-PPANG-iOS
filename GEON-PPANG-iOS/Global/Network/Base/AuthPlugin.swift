//
//  AuthPlugin.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/04.
//

import Foundation

import Moya

final class AuthPlugin: PluginType {
    
    // Request를 보낼 때 호출
    func willSend(_ request: RequestType, target: TargetType) {
        guard let httpRequest = request.request else {
            print("--> 유효하지 않은 요청")
            return
        }
        let url = httpRequest.description
        let method = httpRequest.httpMethod ?? "unknown method"
        #if DEBUG
        var log = "----------------------------------------------------\n\n[\(method)] \(url)\n\n----------------------------------------------------\n"
        log.append("API: \(target)\n")
        if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("header: \(headers)\n")
        }
        if let body = httpRequest.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
            log.append("\(bodyString)\n")
        }
        log.append("------------------- END \(method) --------------------------")
        print(log)
        #endif
    }
    
    // Response가 왔을 때
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            onSucceed(response, target: target, isFromError: false)
        case let .failure(error):
            onFail(error, target: target)
        }
    }
    
    func onSucceed(_ response: Response, target: TargetType, isFromError: Bool) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode
        var log = "------------------- 네트워크 통신 성공 -------------------"
        log.append("\n[\(statusCode)] \(url)\n----------------------------------------------------\n")
        
        if let authorization = response.response?.value(forHTTPHeaderField: "Authorization") {
            UserDefaults.standard.setValue(authorization, forKey: "Authorization")
            print("❤️‍🔥authorization:\(authorization)")
        }
        if let refresh = response.response?.value(forHTTPHeaderField: "Authorization-refresh") {
            UserDefaults.standard.setValue(refresh, forKey: "refresh")
            print("❤️‍🔥autorization-refresh:\(refresh)")
        }
        
    }
    
    func onFail(_ error: MoyaError, target: TargetType) {
        if let response = error.response {
            onSucceed(response, target: target, isFromError: true)
            return
        }
        var log = "네트워크 오류"
        log.append("<-- \(error.errorCode) \(target)\n")
        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
        log.append("<-- END HTTP")
        print(log)
    }
}
