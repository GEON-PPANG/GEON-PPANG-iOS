//
//  CALayer+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor? = .black,
        alpha: Float = 0.16,
        x: CGFloat = 0,
        y: CGFloat = 1,
        blur: CGFloat = 8
    ) {
        shadowColor = color?.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur
    }
}
