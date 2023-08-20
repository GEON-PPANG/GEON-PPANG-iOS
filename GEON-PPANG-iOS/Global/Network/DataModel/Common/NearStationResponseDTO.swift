//
//  NearStationResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/21.
//

import Foundation

struct NearStationResponseDTO: Hashable, Codable {
    
    let firstStation: String
    let secondStation: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case firstStation = "firstNearStation"
        case secondStation = "secondNearStation"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstStation = try container.decode(String.self, forKey: .firstStation)
        secondStation = try container.decodeIfPresent(String.self, forKey: .secondStation)
    }
    
}
