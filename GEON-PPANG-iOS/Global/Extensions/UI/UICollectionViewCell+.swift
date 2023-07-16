//
//  UICollectionViewCell+.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/17.
//

import UIKit

extension UICollectionViewCell {
    
    func fittingSize(availableHeight: CGFloat) -> CGSize {
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return self.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
}
