//
//  OptionsCollectionViewFlowLayout.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

class OptionsCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.minimumLineSpacing = 12.0
        self.sectionInset = UIEdgeInsets(top: 18.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let cellSpacing: CGFloat = 6

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementKind == nil { // nil이 아니면 헤더 nil이면 items
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + cellSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
