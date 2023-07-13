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
        
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - Setting
    
    private func setLayout() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setctionHeaderTitle(_ section: String) {
        var attributedString = NSMutableAttributedString (
            string: section,
            attributes: [
                .font: UIFont.pretendardBold(20),
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
