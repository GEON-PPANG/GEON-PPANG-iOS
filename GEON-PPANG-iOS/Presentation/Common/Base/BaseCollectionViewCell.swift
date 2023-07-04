//
//  File.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/04.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static var id: String {
        return String(describing: self)
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    func setLayout() {
        // override to use
    }
    
    func setStyle() {
        // override to use
    }
    
}
