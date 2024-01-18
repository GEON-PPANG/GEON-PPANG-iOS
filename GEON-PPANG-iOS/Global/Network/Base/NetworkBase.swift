//
//  NetworkBase.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct NetworkBase {
    
    static func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ t: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(Endpoint<T>.self, from: data)
        else { return .pathErr }
        print(decodedData)
        switch statusCode {
        case 200:
            return .success(decodedData.data as Any)
        case 201..<300:
            return .success(decodedData.code)
        case 400..<500:
            return .requestErr(decodedData.code)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
