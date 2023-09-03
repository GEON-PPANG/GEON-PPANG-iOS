//
//  AlertView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/30.
//

import UIKit

import SnapKit
import Then

final class AlertView: UIView {
    
    // MARK: - Property
    
    var alertType: AlertType
    
    var cancelAction: (() -> Void)?
    var acceptAction: (() -> Void)?
    
    // MARK: - UI Property
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let cancelButton = UIButton()
    private let acceptButton = UIButton()
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [cancelButton, acceptButton])
    
    // MARK: - Life Cycle
    
    init(type: AlertType) {
        self.alertType = type
        
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        acceptButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeCornerRound(radius: 12)
        }
        
        imageView.do {
            $0.image = alertType.image
        }
        
        titleLabel.do {
            $0.text = alertType.title
            $0.font = .title2
            $0.textColor = .gbbGray600
            $0.textAlignment = .center
        }
        
        subtitleLabel.do {
            $0.setLineHeight(by: 1.08, with: alertType.subtitle)
            $0.font = .bodyM1
            $0.textColor = .gbbGray400
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        cancelButton.do {
            $0.backgroundColor = .gbbGray200
            $0.setTitle(alertType.cancel, for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.titleLabel?.font = .bodyB1
            $0.makeCornerRound(radius: 8)
            $0.addAction(UIAction { [weak self] _ in
                self?.cancelAction?()
            }, for: .touchUpInside)
        }
        
        acceptButton.do {
            $0.backgroundColor = .gbbMain2
            $0.setTitle(alertType.accept, for: .normal)
            $0.setTitleColor(.gbbWhite, for: .normal)
            $0.titleLabel?.font = .bodyB1
            $0.makeCornerRound(radius: 8)
            $0.addAction(UIAction { [weak self] _ in
                self?.acceptAction?()
            }, for: .touchUpInside)
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
            $0.distribution = .fillEqually
        }
    }
    
}
