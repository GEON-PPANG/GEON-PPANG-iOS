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
    
    // MARK: - UI Property
    
    private lazy var bookmarkCountStackView = IconLabelStackView(type: .bookmark)
    private lazy var reviewCountStackView = IconLabelStackView(type: .review)
    
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
        
        self.addArrangedSubviews(bookmarkCountStackView, reviewCountStackView)
    }
    
    func updateCount(bookmarkCount: Int, reviewCount: Int) {
        
        bookmarkCountStackView.updateCount(bookmarkCount)
        reviewCountStackView.updateCount(reviewCount)
    }
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 6
            $0.distribution = .equalSpacing
        }
    }
}
