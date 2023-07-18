//
//  TestViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/16.
//

import UIKit

class TestViewController: UIViewController {

    private lazy var reviewProgressBarStackView = ReviewProgressBarStackView()
    private lazy var bookmarkReviewStackView = BookmarkReviewNumberStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
    }
}

extension TestViewController {
    
    func setUI() {
        
    }
    
    func setLayout() {
        
        view.addSubviews(reviewProgressBarStackView, bookmarkReviewStackView)
        view.backgroundColor = .gbbWhite
        
        reviewProgressBarStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(134)
            $0.directionalHorizontalEdges.equalToSuperview().inset(33.5)
        }
        
        bookmarkReviewStackView.snp.makeConstraints {
            $0.top.equalTo(reviewProgressBarStackView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
        }
    }
}
