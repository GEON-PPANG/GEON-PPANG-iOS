//
//  ReviewDetailTextView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

final class ReviewDetailTextView: UIView {
    
    // MARK: - Property
    
    var isLike: Bool = true {
        didSet {
            
        }
    }
    
    var isEnabled: Bool = false {
        didSet {
            toggleInteraction()
            toggleUI()
        }
    }
    
    // MARK: - UI Property
    
    let detailTextView = UITextView()
    private let textLimitLabel = UILabel()
    private let textMinimumLimitLabel = UILabel()
    
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
        
        addSubview(textMinimumLimitLabel)
        textMinimumLimitLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(7)
            $0.trailing.equalTo(detailTextView)
            $0.height.equalTo(17)
        }
        
        addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(7)
            $0.trailing.equalTo(textMinimumLimitLabel.snp.leading).offset(-4)
            $0.height.equalTo(17)
        }
    }
    
    private func setUI() {
        detailTextView.do {
            $0.text = I18N.reviewDetailTextViewLikePlaceholder
            $0.font = .subHead
            $0.textColor = .gbbGray300
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbGray300!)
            $0.contentInset = .init(top: 20, left: 28, bottom: 16, right: 28)
        }
        
        textLimitLabel.do {
            $0.text = "0/500"
            $0.font = .captionM1
            $0.textColor = .gbbGray300
        }
        
        textMinimumLimitLabel.do {
            $0.text = "(최소 10자)"
            $0.font = .captionM1
            $0.textColor = .gbbGray300
        }
    }
    
    // MARK: - Custom Method
    
    private func toggleInteraction() {
        detailTextView.isUserInteractionEnabled.toggle()
    }
    
    private func toggleUI() {
        detailTextView.do {
            $0.textColor = isEnabled ? .gbbGray400 : .gbbGray300
        }
        
        textLimitLabel.do {
            $0.textColor = isEnabled ? .gbbGray400 : .gbbGray300
        }
        
        textMinimumLimitLabel.do {
            $0.textColor = isEnabled ? .gbbGray400 : .gbbGray300
        }
    }
    
    private func toggleTextViewPlaceholder() {
        detailTextView.do {
            $0.text = isLike ? I18N.reviewDetailTextViewLikePlaceholder : I18N.reviewDetailTextViewDislikePlaceholder
        }
    }
    
    func updateTextLimitLabel(to num: Int) {
        textLimitLabel.do {
            $0.text = "\(num)/500"
        }
    }
    
}
