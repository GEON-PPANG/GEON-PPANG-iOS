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
    
    private let labeling = ["웹사이트", "인스타그램"]
    
    // MARK: - UI Property
    
    private lazy var homepageLinkButton = UIButton()
    private lazy var instagramLinkButton = UIButton()
    
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
        
        [homepageLinkButton, instagramLinkButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(20)
            }
        }
        
        homepageLinkButton.snp.makeConstraints {
            $0.width.equalTo(52)
        }
        
        instagramLinkButton.snp.makeConstraints {
            $0.width.equalTo(65)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .equalSpacing
        }
        
        // TODO: 클릭 시 사파리로 이동 (API 통신 필요)
        // 이 부분 귀찮아서 이렇게 해버렸는데 더 좋은 방법이 있다면 인사이트 공유 부탁합니다 ..
        [homepageLinkButton, instagramLinkButton].enumerated().forEach { index, button in
            button.do {
                $0.setTitle(labeling[index], for: .normal)
                $0.setTitleColor(.gbbGray400, for: .normal)
                $0.setUnderline()
                $0.titleLabel?.font = .subHead
                $0.isHidden = true
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
