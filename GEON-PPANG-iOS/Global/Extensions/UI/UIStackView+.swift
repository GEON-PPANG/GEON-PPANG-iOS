//
//  UIStackView+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/03.
//

import UIKit

extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
