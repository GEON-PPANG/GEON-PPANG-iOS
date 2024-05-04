//
//  DetailReasonTextView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/09/19.
//

import UIKit

import SnapKit
import Then

final class DetailReasonTextView: UIView {
    
    // MARK: - UI Property
    
    let detailTextView = UITextView()
    let textLimitLabel = UILabel()
    
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
        
        self.addSubview(detailTextView)
        detailTextView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.width.equalTo(327)
            $0.height.equalTo(199)
        }
        
        self.addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(162)
            $0.trailing.equalToSuperview().inset(28)
            $0.width.equalTo(60)
            $0.height.equalTo(17)
        }
    }
    
    private func setUI() {
        
        detailTextView.do {
            $0.text = I18N.Report.detailPlaceholder
            $0.font = .subHead
            $0.textColor = .gbbGray300
            $0.autocorrectionType = .no // 자동완성 비활성화
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbGray300)
            $0.textContainerInset = .init(top: 20, left: 24, bottom: 49, right: 24)
            $0.clipsToBounds = true
        }
        
        textLimitLabel.do {
            $0.basic(text: "0/140자", font: .captionM1!, color: .gbbGray300)
            $0.textAlignment = .right
        }
    }
    
    // MARK: - Custom Method
    
    func updateTextLimitLabel(to textCount: Int) {
        
        textLimitLabel.do {
            $0.text = "\(textCount)/140자"
        }
    }
}
