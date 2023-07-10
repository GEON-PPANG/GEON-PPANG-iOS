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
    
    private let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
        
        Sections.allCases.forEach {
            headerLabel.text = $0.title
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        headerLabel.do {
            $0.partColorChange(targetString: "Best리뷰", textColor: .gbbPoint2!)
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
    
    func setctionHeaderTitle(_ section: Sections) {
        headerLabel.text = section.title
    }
}
