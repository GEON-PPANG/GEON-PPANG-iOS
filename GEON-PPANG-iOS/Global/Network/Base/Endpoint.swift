//
//  GeneralResponse.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct Endpoint<T: Decodable>: Decodable {
    var code: Int
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case code
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
        code = (try? values.decode(Int.self, forKey: .code)) ?? 0
    }
}

struct ArrayEndpoint<T: Decodable>: Decodable {
    let code: Int
    let message: String?
    let data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case code
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([T].self, forKey: .data)) ?? []
        code = (try? values.decode(Int.self, forKey: .code)) ?? 0
    }
}

/// status, message, success 이외에 정보를 사용하지 않는 경우에 VoidType를 설정해주면 됩니다!
struct VoidType: Decodable {}
