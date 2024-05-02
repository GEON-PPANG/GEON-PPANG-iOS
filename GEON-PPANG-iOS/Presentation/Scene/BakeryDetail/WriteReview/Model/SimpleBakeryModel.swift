//
//  SimpleBakeryModel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/21.
//

import UIKit

struct SimpleBakeryModel {
    var id: Int
    var name: String
    var imageURL: String
    var ingredients: [String]
    var region: [String]
    var certificates: CertificationMarkResponseType
    
    static func emptyModel() -> SimpleBakeryModel {
        
        return .init(
            id: 0,
            name: "",
            imageURL: "",
            ingredients: [],
            region: [],
            certificates: .init(isHACCP: false, isVegan: false, isNonGMO: false)
        )
    }
}
