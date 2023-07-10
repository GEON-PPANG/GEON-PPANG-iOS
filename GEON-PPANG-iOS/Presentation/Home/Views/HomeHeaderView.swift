//
//  HomeHeaderView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class HomeHeaderView: UICollectionReusableView {
    
    // MARK: - UI Property
    
    private let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - Setting
    
    private func setUI() {
        headerLabel.do {
            $0.basic(font: .pretendardBold(20), color: .gbbGray700!)
            
        }
    }
    
    private func setLayout() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setctionHeaderTitle(_ section: String) {
        headerLabel.text = section  
    }
}
