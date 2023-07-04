//
//  BaseTableViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/04.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    static var id: String {
        return String(describing: self)
    }
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
