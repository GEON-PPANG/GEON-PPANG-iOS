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
    
    class func emptySection(withHeight height: CGFloat = 0, hasHeader: Bool) -> NSCollectionLayoutSection {
        
        let group = LayoutUtils.emptyGroup()
        let section = NSCollectionLayoutSection(group: group)
        
        if hasHeader {
            section.boundarySupplementaryItems = [LayoutUtils.header(ofHeight: height)]
        }
        
        return section
    }
    
    class func header(ofHeight height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        return header
    }
    
    class func listConfiguration(
        appearance: UICollectionLayoutListConfiguration.Appearance,
        headerMode: UICollectionLayoutListConfiguration.HeaderMode,
        handler: UICollectionLayoutListConfiguration.ItemSeparatorHandler?
    ) -> UICollectionLayoutListConfiguration {
        
        var config = UICollectionLayoutListConfiguration(appearance: appearance)
        config.backgroundColor = .clear
        config.separatorConfiguration.color = .gbbGray200!
        config.headerMode = headerMode
        config.separatorConfiguration.topSeparatorVisibility = .hidden
        config.itemSeparatorHandler = handler
        return config
    }
}
