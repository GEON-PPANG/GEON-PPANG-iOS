//
//  TestViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/16.
//

import UIKit

class TestViewController: UIViewController {

    private let reviewProgressBarStackView = ReviewProgressBarStackView()
    
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
        
        view.addSubview(reviewProgressBarStackView)
        view.backgroundColor = .gbbWhite
        
        reviewProgressBarStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(134)
            $0.directionalHorizontalEdges.equalToSuperview().inset(33.5)
        }
    }
}
