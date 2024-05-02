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
    
    typealias Action = () -> Void
    
    // MARK: - Property
    
    var leaveTapepd: Action?
    
    // MARK: - UI Property
    
    private let leaveButton = UIButton()
    
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
        
        self.addSubview(leaveButton)
        leaveButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(4)
            $0.height.equalTo(48)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        leaveButton.do {
            $0.setTitle(I18N.MyPage.leave, for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.titleLabel?.font = .bodyM2
            $0.contentHorizontalAlignment = .leading
            $0.addAction(UIAction { [weak self] _ in
                self?.leaveTapepd?()
            }, for: .touchUpInside)
        }
        
    }
    
}
