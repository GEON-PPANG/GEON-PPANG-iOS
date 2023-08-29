//
//  BookmarkCountLabel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/21.
//

import UIKit

import SnapKit
import Then

final class BookmarkCountLabel: UILabel {
    
    // MARK: - Property
    
    private let bookmarkCount: Int
    
    // MARK: - UI Property
    
    private let imageView = UIImageView(image: .bookmarkIcon16px400)
    private let label = UILabel()
    
    // MARK: - Life Cycle
    
    init(count: Int) {
        self.bookmarkCount = count
        
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
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(1)
            $0.centerY.equalTo(imageView)
            $0.trailing.equalToSuperview()
        }
    }
    
    private func setUI() {
        
        label.do {
            $0.text = "(\(bookmarkCount))"
            $0.font = .captionB1
            $0.textColor = .gbbGray400
        }
    }
    
}
