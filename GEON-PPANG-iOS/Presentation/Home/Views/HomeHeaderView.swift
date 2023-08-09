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
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - Setting
    
    private func setLayout() {
        
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureSectionHeaderTitle(_ section: String) {
        let attributedString = NSMutableAttributedString(
            string: section,
            attributes: [
                .font: UIFont.title2!,
                .foregroundColor: UIColor.gbbGray700!
            ]
        )
        
        attributedString.addAttributes(
            [.foregroundColor: UIColor.gbbPoint1!],
            range: NSRange(
                location: section.count - 8,
                length: 8
            )
        )
        headerLabel.attributedText = attributedString
    }
}
