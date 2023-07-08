//
//  ReviewDetailTextView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

final class ReviewDetailTextView: UIView {
    
    // MARK: - Property
    
    var numOfWords: Int = 0
    
    // MARK: - UI Property
    
    let detailTextView = UITextView()
    private let textLimitLabel = UILabel()
    private let textMinimumLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(detailTextView)
        detailTextView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(196)
        }
        
        addSubview(textMinimumLabel)
        textMinimumLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(7)
            $0.trailing.equalTo(detailTextView)
        }
        
        addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(7)
            $0.trailing.equalTo(textMinimumLabel.snp.leading).offset(4)
        }
    }
    
    private func setUI() {
        detailTextView.do {
            $0.contentInset = .init(top: 20, left: 28, bottom: 16, right: 28)
            $0.font = .subHead
            $0.textColor = .gbbGray600
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbGray400!)
        }
        
        textLimitLabel.do {
            $0.text = "\(numOfWords)/500"
            $0.font = .captionM1
            $0.textColor = .gbbGray400
        }
        
        textMinimumLabel.do {
            $0.text = "(최소 10자)"
            $0.font = .captionM1
            $0.textColor = .gbbGray400
        }
    }
    
    // MARK: - Custom Method
    
    
    
}
