//
//  Encodable+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/03.
//

import Foundation

extension Encodable {
    
    func asParameter() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                as? [String: Any] else {
            throw NSError()
        }
        
        return dictionary
    }
}
