//
//  Buildable.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/06.
//

import UIKit

protocol Buildable {
    associatedtype ViewType
    func build(_ config: ((ViewType) -> Void)?) -> ViewType
}

