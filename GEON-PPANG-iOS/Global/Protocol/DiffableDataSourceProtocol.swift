//
//  DiffableProtocol.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/28.
//

import UIKit

protocol DiffableDataSourceProtocol {
    var headerType: String { get }
    var footerType: String { get }
    
    func setCollectionView()
    func setDataSource()
}

extension DiffableDataSourceProtocol {
    var headerType: String {
        return UICollectionView.elementKindSectionHeader
    }
    var footerType: String {
        return UICollectionView.elementKindSectionFooter
    }
}
