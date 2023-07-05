//
//  DynamicWidthFlowLayout.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/05.
//

import UIKit

import Then

class DynamicWidthFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Life Cycle
    
    override init() {
        super.init()
        
        setProperty()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setProperty() {
        self.do {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
}
