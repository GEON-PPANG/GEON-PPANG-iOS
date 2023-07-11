//
//  SearchInitialCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

final class SearchInitialCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private let initialIcon = UIImageView()
    private let initialLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubviews(initialIcon, initialLabel)
        
        initialIcon.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 154, height: 132))
            $0.centerX.equalToSuperview()
        }
        
        initialLabel.snp.makeConstraints {
            $0.top.equalTo(initialIcon.snp.bottom).offset(20)
            $0.centerY.equalToSuperview().inset(-35)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setUI() {
        initialIcon.do {
            $0.contentMode = .scaleAspectFit
        }
        initialLabel.do {
            $0.textAlignment = .center
            $0.basic(text: "궁금하신 건빵집을 \n검색해보세요!", font: .pretendardBold(20), color: .gbbGray300!)
        }
        
    }
    
}
