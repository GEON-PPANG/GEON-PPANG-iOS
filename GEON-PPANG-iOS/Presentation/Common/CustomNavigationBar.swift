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
        static let backButtonSize = 24
        static let mapButtonSize = 34
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
        setStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(Size.backButtonSize)
        }
    }
    
    private func setStyle() {
        backButton.do {
            // TODO: asset 추가되면 image, color 변경
            $0.tintColor = .black
        }
    }
    
    // MARK: - Custom Method
    
    func addBackButtonAction(_ action: UIAction) {
        backButton.addAction(action, for: .touchUpInside)
    }
    
    func addMapButtonAction(_ action: UIAction) {
        rightMapButton.addAction(action, for: .touchUpInside)
    }
    
    func configureLeftTitle(to title: String, with font: UIFont) {
        addSubview(leftTitleLabel)
        leftTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.centerY.equalTo(backButton)
        }
        leftTitleLabel.do {
            $0.text = title
            // TODO: font 변동 가능성 있을수도 ? 없다면 지우기
            $0.font = font
            // TODO: asset 추가되면 color 변경
            $0.textColor = .black
        }
    }
    
    func configureRightCount(_ currentCount: Int, by maxCount: Int) {
        addSubview(rightCountLabel)
        rightCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(backButton)
        }
        rightCountLabel.do {
            $0.text = "\(currentCount)/\(maxCount)"
            $0.font = .pretendardMedium(15)
            // TODO: asset 추가되면 color 변경
            $0.textColor = .systemGray
        }
    }
    
    func configureRightMapButton() {
        addSubview(rightMapButton)
        rightMapButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(Size.mapButtonSize)
            $0.centerY.equalTo(backButton)
        }
        
        let mapImageView = UIImageView(image: UIImage(systemName: "map.circle.fill"))
        rightMapButton.addSubview(mapImageView)
        mapImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mapImageView.do {
            // TODO: asset 추가되면 color 변경
            $0.tintColor = .systemGray2
        }
    }
    
}
