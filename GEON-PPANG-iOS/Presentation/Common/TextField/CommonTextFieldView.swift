//
//  CommonTextFieldView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/13.
//

import UIKit

enum LogoinPropetyType: String {
    case email = "이메일"
    case password = "비밀번호"
    case checkPasswaord = "비밀번호 재확인"
    case nickname = "닉네임"
}

final class CommonTextFieldView: UIView {

    private let commonTextField = UITextField()
    private let titleLabel = UILabel()
    private let checkLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        commonTextField.do {
            $0.makeCornerRound(radius: 10)
            $0.makeBorder(width: 1, color: .black)
            $0.setPlaceholder(color: .gbbGray300!, font: .headLine)
        }
        
        titleLabel.do {
            $0.basic(font: .bodyB2!, color: .gbbGray400!)
        }
        
        checkLabel.do {
            $0.font = .captionM1
        }
    }
    
    private func setUI() {
        addSubviews(commonTextField, checkLabel)
        commonTextField.addSubview(titleLabel)
        
        commonTextField.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(18)
        }
        
        checkLabel.snp.makeConstraints {
            $0.top.equalTo(commonTextField.snp.bottom).offset(7)
            $0.trailing.equalToSuperview()
        }
    }

}
