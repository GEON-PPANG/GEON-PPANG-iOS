//
//  BakeryDetailReviewProgressView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class BakeryDetailReviewProgressView: UIView {

    // MARK: - UI Property
    
    private let reviewProgressBar = UIProgressView()
    private let reviewLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setting
    
    private func setUI() {
        
    }
    
    private func setLayout() {
        
    }
}
