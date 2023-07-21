//
//  SimpleBakeryModel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/21.
//

import UIKit

struct SimpleBakeryModel {
    var bakeryID: Int
    var bakeryName: String
    var bakeryImageURL: String
    var bakeryIngredients: [String]
    var bakeryRegion: [String]
    
    static func emptyModel() -> SimpleBakeryModel {
        return .init(bakeryID: 0,
                     bakeryName: "",
                     bakeryImageURL: "",
                     bakeryIngredients: [],
                     bakeryRegion: [])
    }
}
