//
//  BestBakeryDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/29/24.
//
import Foundation

struct BestBakeryResponseDTO: Decodable {
    
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP, isVegan, isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String
    let reviewCount, bookMarkCount: Int
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName
        case bakeryPicture
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case reviewCount
        case bookMarkCount
    }
    
}

extension BestBakeryResponseDTO {

    func toDomain() -> BestBakery {
        let overview: BakeryOverview = .init(
            id: bakeryID,
            name: bakeryName,
            image: bakeryPicture
        )
        let certifications: Certifications = .init(
            isHaccp: isHACCP,
            isVegan: isVegan,
            isNonGMO: isNonGMO
        )
        let regions: Regions = .init(
            firstRegion: firstNearStation,
            secondRegion: secondNearStation
        )
        
        return BestBakery(
            overview: overview,
            certifications: certifications,
            bookmarkCount: bookMarkCount,
            reviewCount: reviewCount,
            regions: regions
        )
    }
}

