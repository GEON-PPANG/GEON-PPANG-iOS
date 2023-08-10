//
//  CustomNavigationBar.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/04.
//

import UIKit

import SnapKit
import Then

final class CustomNavigationBar: UIView {
    
    // MARK: - Property
    
    enum Size {
        static let buttonSize = 48
    }
    
    // MARK: - UI Property
    
    private let backButton = BackButton()
    
    private lazy var leftTitleLabel = UILabel()
    
    private lazy var rightCountLabel = UILabel()
    private lazy var rightMapButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(CGFloat().heightConsideringNotch(118))
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(Size.buttonSize)
        }
    }
    
    private func setStyle() {
        
        backButton.do {
            $0.tintColor = .gbbGray700
        }
    }
    
    // MARK: - Custom Method
    
    func configureBackButtonAction(_ action: UIAction) {
        
        backButton.addAction(action, for: .touchUpInside)
    }
    
    func configureMapButtonAction(_ action: UIAction) {
        
        rightMapButton.addAction(action, for: .touchUpInside)
    }
    
    func configureLeftTitle(to title: String) {
        
        self.addSubview(leftTitleLabel)
        leftTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.centerY.equalTo(backButton)
        }
        
        leftTitleLabel.do {
            $0.text = title
            $0.font = .title2
            $0.textColor = .black
        }
    }
    
    func configureRightCount(_ currentCount: Int, by maxCount: Int) {
        
        self.addSubview(rightCountLabel)
        rightCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(backButton)
        }
        
        rightCountLabel.do {
            $0.text = "\(currentCount)/\(maxCount)"
            $0.font = .pretendardMedium(15)
            $0.textColor = .gbbGray300
        }
    }
    
    func configureRightMapButton() {
        
        self.addSubview(rightMapButton)
        rightMapButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.centerY.equalTo(backButton)
            $0.width.height.equalTo(Size.buttonSize)
        }
        
        let mapImageView = UIImageView(image: UIImage.mapButton)
        
        rightMapButton.addSubview(mapImageView)
        mapImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(Size.buttonSize)
        }
        
        mapImageView.do {
            $0.tintColor = .gbbGray500
        }
    }
    
    func configureBottomLine() {
        
        let bottomLine = LineView()
        
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
