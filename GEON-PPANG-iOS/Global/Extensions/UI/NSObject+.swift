//
//  NSObject+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/03.
//

import UIKit

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
