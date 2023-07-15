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
    private lazy var dotButton = UIButton()
    
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
        self.addSubviews(dateLabel, dotButton)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        dotButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.directionalVerticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setUI() {
        dateLabel.do {
            $0.basic(text: "23.08.09",
                     font: .captionM1!,
                     color: .gbbGray400!)
        }
        
        dotButton.do {
            $0.setImage(.dotdotdotIcon, for: .normal)
            $0.addAction(UIAction { _ in
                print("myreviews Tapped")
            }, for: .touchUpInside)
        }
    }
    
}
