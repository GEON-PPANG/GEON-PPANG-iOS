//
//  LinkButtonStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/09/05.
//

import UIKit

import SnapKit
import Then

final class LinkButtonStackView: UIStackView {
    
    // MARK: - Property
    
    var tappedHomepageLinkButton: (() -> Void)?
    var tappedInstagramLinkButton: (() -> Void)?
    
    // MARK: - UI Property
    
    lazy var homepageLinkButton = UIButton()
    lazy var instagramLinkButton = UIButton()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addArrangedSubviews(homepageLinkButton, instagramLinkButton)
        
        homepageLinkButton.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(52)
        }
        
        instagramLinkButton.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(65)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .equalSpacing
        }
        
        [homepageLinkButton, instagramLinkButton].enumerated().forEach { index, button in
            let title = index == 0 ? I18N.Detail.homepage : I18N.Detail.instagram
            let tappedLinkButton = index == 0 ? self.tappedHomepageLinkButton : self.tappedInstagramLinkButton
            
            button.do {
                $0.setTitle(title, for: .normal)
                $0.setTitleColor(.gbbGray400, for: .normal)
                $0.setUnderline()
                $0.titleLabel?.font = .subHead
                $0.isHidden = true
                
                $0.addAction(UIAction { _ in
                    tappedLinkButton?()
                }, for: .touchUpInside)
            }
        }
    }
    
    // MARK: - Custom Method
    
    func getLinkStatus(_ homepageURL: String, _ instagramURL: String) {
        
        if homepageURL != "" {
            homepageLinkButton.isHidden = false
        }
        
        if instagramURL != "" {
            instagramLinkButton.isHidden = false
        }
    }
}
