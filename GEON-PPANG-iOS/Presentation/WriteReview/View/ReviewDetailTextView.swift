//
//  ReviewDetailTextView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

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
    
    private var type: ReviewViewType
    private var status: TextViewStatus = .deactivated
    
    var isLike: Bool = true {
        willSet {
            configurePlaceholder(with: newValue)
        }
    }
    
    // MARK: - UI Property
    
    let detailTextView = UITextView()
    private let textLimitLabel = UILabel()
    
    // MARK: - Life Cycle
    
    init(type: ReviewViewType) {
        self.type = type
        
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        setWhenWriting()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(detailTextView)
        detailTextView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(196)
        }
    }
    
    private func setUI() {
        
        detailTextView.do {
            $0.text = I18N.Review.likePlaceholder
            $0.font = .subHead
            $0.textColor = .gbbGray300
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbGray300!)
            $0.textContainerInset = .init(top: 20, left: 28, bottom: 45, right: 28)
            $0.clipsToBounds = true
        }
    }
    
    private func setWhenWriting() {
        guard type == .write else { return }
        
        self.addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.bottom.equalTo(detailTextView.snp.bottom).offset(-20)
            $0.trailing.equalTo(detailTextView).offset(-28)
            $0.height.equalTo(17)
        }
        
        textLimitLabel.do {
            $0.text = "0/120자"
            $0.font = .captionM1
            $0.textColor = .gbbGray300
        }
    }
    
    // MARK: - Custom Method
    
    func configureTextView(to status: TextViewStatus) {
        
        self.status = status
        
        detailTextView.do {
            $0.textColor = textColor
            $0.makeBorder(width: 1, color: borderColor)
        }
        
        guard type == .write else { return }
        textLimitLabel.do {
            $0.textColor = textColor
        }
    }
    
    func configurePlaceholder(with isLike: Bool) {
        
        detailTextView.do {
            $0.text = isLike ? I18N.Review.likePlaceholder : I18N.Review.dislikePlaceholder
        }
    }
    
    func updateTextLimitLabel(to num: Int) {
        
        guard type == .write else { return }
        textLimitLabel.do {
            $0.text = "\(num)/120자"
        }
    }
}
