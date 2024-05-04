//
//  BackButton.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/04.
//

import UIKit

final class BackButton: UIButton {
    
    // MARK: - UI Property
    
    private let leftChevron = UIImageView(image: .Icon.Arrow.left)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .init(x: 0,
                                y: 0,
                                width: 48,
                                height: 48))
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(leftChevron)
        leftChevron.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(10)
        }
    }
    
    private func setUI() {
        
        leftChevron.do {
            $0.contentMode = .scaleAspectFill
        }
    }
    
}
