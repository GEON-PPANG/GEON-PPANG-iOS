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
    private let appVersionNumButton = UIButton()
    
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
        
        self.addSubview(appVersionLabel)
        appVersionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(12)
        }
        
        self.addSubview(appVersionNumButton)
        appVersionNumButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(appVersionLabel)
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
        
        appVersionNumButton.do {
            $0.setTitle(I18N.MyPage.appVersionNum, for: .normal)
            $0.setTitleColor(.gbbMain1, for: .normal)
            $0.titleLabel?.font = .captionM1
            $0.addAction(UIAction { [weak self] _ in
                self?.appVersionButtonTapped()
            }, for: .touchUpInside)
        }
    }
    
    // MARK: - Action Helper
    
    private func appVersionButtonTapped() {
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewControllerToOnboardingViewController()
    }
    
}
