//
//  BottomView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class BottomView: UIView {
    
    // MARK: - Life Cycle
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setShadow()
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Setting
//
    private func setShadow() {
        self.layer.applyShadow(color: .init(red: 0, green: 0, blue: 0, alpha: 0.1),
                               alpha: 1,
                               x: 0,
                               y: 1,
                               blur: 10)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setShadow()
    }
    
    // MARK: - Custom Method
    
    func applyAdditionalSubview(_ view: UIView, withTrailingOffset offset: CGFloat = 24) {
        addSubview(view)
        view.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(offset)
            $0.top.equalToSuperview().inset(offset)
        }
    }
    
}
