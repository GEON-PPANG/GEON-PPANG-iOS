//
//  BookmarkReviewNumberStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/17.
//

import UIKit

import SnapKit
import Then

final class BookmarkReviewNumberStackView: UIStackView {

    // MARK: - UIProperty
    
    private lazy var bookmarkCountStackView = CountStackView(type: .bookmark)
    private lazy var reviewCountStackView = CountStackView(type: .review)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 6
            $0.distribution = .equalSpacing
        }
    }
    
    private func setLayout() {
        
        self.addArrangedSubviews(bookmarkCountStackView, reviewCountStackView)
    }
}
