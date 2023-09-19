//
//  MyReviewsHeaderView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyReviewsHeaderView: UICollectionReusableView {
    
    // MARK: - UI Property
    
    private let dateLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(21)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        dateLabel.do {
            $0.basic(font: .captionM1!,
                     color: .gbbGray400!)
        }
    }
    
    func configuteDateText(_ date: String) {
        dateLabel.text = date
    }
}
