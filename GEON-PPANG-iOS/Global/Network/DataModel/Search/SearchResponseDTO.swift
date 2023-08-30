//
//  SearchResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import Foundation

// MARK: - SearchResponseDTO

struct SearchResponseDTO: Decodable, Hashable {
    
    let resultCount: Int
    let bakeryList: [BakeryCommonListResponseDTO]
    
}
