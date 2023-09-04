//
//  LayoutUtils.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/04.
//

import UIKit

final class LayoutUtils {
    
    class func emptyGroup() -> NSCollectionLayoutGroup {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return group
    }
    
    class func section(_ exists: Bool, _ size: CGFloat? = 0) -> NSCollectionLayoutSection {
        
        let group = LayoutUtils.emptyGroup()
        let section = NSCollectionLayoutSection(group: group)
        
        if exists {
            section.boundarySupplementaryItems = [LayoutUtils.header(size ?? 0)]
        }
        
        return section
    }
    
    class func header(_ headerSize: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(headerSize))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        return header
    }
}
