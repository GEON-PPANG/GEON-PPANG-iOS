//
//  HomeBestBakeryResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//
//

import Foundation

struct HomeBestBakeryResponseDTO: Codable, Hashable {

    var id = UUID()

    let bakeries: HomeCommonResponseDTO

    init(from decoder: Decoder) throws {

        bakeries = try HomeCommonResponseDTO(from: decoder)
    }

    func hash(into hasher: inout Hasher) {
        
        hasher.combine(id)
    }

    static func == (lhs: HomeBestBakeryResponseDTO, rhs: HomeBestBakeryResponseDTO) -> Bool {
        lhs.id == rhs.id
    }

}
