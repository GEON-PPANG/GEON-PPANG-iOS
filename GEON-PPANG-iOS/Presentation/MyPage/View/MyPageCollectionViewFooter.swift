//
//  MyPageCollectionViewFooter.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyPageCollectionViewFooter: UICollectionReusableView {
    
    // MARK: - UI Property
    
    private let appVersionLabel = UILabel()
    private let appVersionNumLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(appVersionLabel)
        appVersionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(appVersionNumLabel)
        appVersionNumLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setUI() {
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        appVersionLabel.do {
            $0.text = I18N.MyPage.appVersion
            $0.font = .captionM1
            $0.textColor = .gbbMain1
        }
        
        appVersionNumLabel.do {
            $0.text = I18N.MyPage.appVersionNum
            $0.font = .captionM1
            $0.textColor = .gbbMain1
        }
    }
    
}
