//
//  ReviewDetailTextView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

final class ReviewDetailTextView: UIView {
    
    // MARK: - Property
    
    enum TextViewStatus {
        case deactivated
        case activated
        case error
    }
    
    private var borderColor: UIColor {
        switch status {
        case .deactivated: return .gbbGray300!
        case .activated: return .gbbGray500!
        case .error: return .gbbError!
        }
    }
    
    private var textColor: UIColor {
        switch status {
        case .deactivated: return .gbbGray300!
        case .activated: return .gbbGray700!
        case .error: return .gbbError!
        }
    }
    
    private var status: TextViewStatus = .deactivated
    
    var isLike: Bool = true {
        willSet {
            configurePlaceholder(with: newValue)
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
            $0.text = I18N.likePlaceholder
            $0.font = .subHead
            $0.textColor = .gbbGray300
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbGray300!)
            $0.contentInset = .init(top: 20, left: 28, bottom: 16, right: 28)
        }
        
        textLimitLabel.do {
            $0.text = "0/500"
            $0.font = .captionM1
            $0.textColor = .gbbGray500
        }
        
        textMinimumLimitLabel.do {
            $0.text = "(최소 10자)"
            $0.font = .captionM1
            $0.textColor = .gbbGray500
        }
    }
    
    // MARK: - Custom Method
    
    func configureTextView(to status: TextViewStatus) {
        self.status = status
        
        detailTextView.do {
            $0.textColor = textColor
            $0.makeBorder(width: 1, color: borderColor)
        }
    }
    
    func configurePlaceholder(with isLike: Bool) {
        detailTextView.do {
            $0.text = isLike ? I18N.likePlaceholder : I18N.dislikePlaceholder
        }
    }
    
    func updateTextLimitLabel(to num: Int) {
        textLimitLabel.do {
            $0.text = "\(num)/500"
        }
    }
    
}
