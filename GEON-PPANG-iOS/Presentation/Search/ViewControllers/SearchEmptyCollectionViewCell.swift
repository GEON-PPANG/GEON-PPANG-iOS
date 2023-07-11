//
//  SearchEmptyCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

final class SearchEmptyCollectionViewCell: UICollectionViewCell {
    
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
            $0.centerY.equalToSuperview().inset(-33)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setUI() {
        initialIcon.do {
            $0.contentMode = .scaleAspectFit
            $0.image = .noSearchResultImage
        }
        initialLabel.do {
            $0.textAlignment = .center
            $0.basic(text: "검색결과가 없어요\n다른 키워드로 검색해보세요!", font: .pretendardBold(20), color: .gbbGray300!)
            $0.partFontChange(targetString: "다른 키워드로 검색해보세요!", font: .pretendardMedium(15))
        }
        
    }
    
}
