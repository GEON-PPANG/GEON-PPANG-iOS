//
//  CertificationMarkResponseType.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/21.
//

import Foundation

struct CertificationMarkResponseType: Hashable, Codable {
    
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool

}
