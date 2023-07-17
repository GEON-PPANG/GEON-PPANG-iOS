//
//  InfoCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class InfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    //    private let bakeryDetailInfoLabel = UILabel()
    //    private let ingredientNoticeLabel = UILabel()
    private let homepageLinkImage = UIImageView()
    private let homepageLinkButton = UIButton() // 서버
    private let bakeryAddressImage = UIImageView()
    private lazy var bakeryAddressLabel = UILabel() // 서버
    private lazy var addressCopyButton = UIButton() // 서버
    private lazy var regionStackView = RegionStackView() // 서버
    private let bakeryOpeningHoursImage = UIImageView()
    private let bakeryClosedDaysLabel = UILabel() // 서버
    private let bakeryOpeningHoursLabel = UILabel() // 서버
    private let bakeryPhoneNumberImage = UIImageView()
    private let bakeryPhoneNumberLabel = UILabel() // 서버
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        homepageLinkImage.do {
            $0.image = .linkIcon
        }
        
        homepageLinkButton.do {
            $0.setUnderline()
            $0.titleLabel?.basic(text: "홈페이지로 이동", font: .subHead!, color: .gbbGray400!)
            $0.titleLabel?.textAlignment = .center
        }
        
        bakeryAddressImage.do {
            $0.image = .storeIcon
        }
        
        bakeryAddressLabel.do {
            $0.basic(text: "경기 의왕시 신장승길 29 퍼스트힐5차 111호", font: .subHead!, color: .gbbGray400!)
        }
        
        addressCopyButton.do {
            $0.setImage(.copyButton, for: .normal)
        }
        
        bakeryOpeningHoursImage.do {
            $0.image = .timeIcon
        }
        
        bakeryClosedDaysLabel.do {
            $0.basic(text: "월,화 휴무", font: .subHead!, color: .gbbError!)
        }
        
        bakeryOpeningHoursLabel.do {
            $0.basic(text: "수-금: 12:00 ~ 19:00 / 토-일 13:00 ~ 19:00", font: .subHead!, color: .gbbGray400!)
        }
        
        bakeryPhoneNumberImage.do {
            $0.image = .callIcon
        }
        
        bakeryPhoneNumberLabel.do {
            $0.basic(text: "02-033-3333", font: .subHead!, color: .gbbGray400!)
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(homepageLinkImage, homepageLinkButton, bakeryAddressImage, bakeryAddressLabel, addressCopyButton, regionStackView, bakeryOpeningHoursImage, bakeryClosedDaysLabel, bakeryOpeningHoursLabel, bakeryPhoneNumberImage, bakeryPhoneNumberLabel)
        
        homepageLinkImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        homepageLinkButton.snp.makeConstraints {
            $0.centerY.equalTo(homepageLinkImage)
            $0.leading.equalTo(homepageLinkImage.snp.trailing).offset(10)
            $0.width.equalTo(95)
            $0.height.equalTo(20)
        }
        
        bakeryAddressImage.snp.makeConstraints {
            // TODO: 2줄이면 URL 기준 18만큼 아래, 1줄이면 아이콘 기준 18만큼 아래로
            $0.top.equalTo(homepageLinkImage.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        bakeryAddressLabel.snp.makeConstraints {
            $0.centerY.equalTo(bakeryAddressImage)
            $0.leading.equalTo(homepageLinkButton)
            //TODO: 동적으로 skrrr
            $0.trailing.equalToSuperview().offset(44)
            $0.width.equalTo(249)
            $0.height.equalTo(20)
        }
        
        addressCopyButton.snp.makeConstraints {
            $0.top.equalTo(bakeryAddressImage)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryAddressLabel.snp.bottom).offset(13)
            $0.leading.equalTo(bakeryAddressLabel)
        }
        
        bakeryOpeningHoursImage.snp.makeConstraints {
            $0.top.equalTo(regionStackView.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        bakeryClosedDaysLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryOpeningHoursImage)
            $0.leading.equalTo(bakeryAddressLabel)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(293)
            $0.height.equalTo(20)
        }
        
        bakeryOpeningHoursLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryClosedDaysLabel.snp.bottom).offset(2)
            $0.leading.equalTo(bakeryClosedDaysLabel)
            //TODO: 동적으로 skrrr
            $0.trailing.equalToSuperview()
            $0.width.equalTo(293)
            $0.height.equalTo(20)
        }
        
        bakeryPhoneNumberImage.snp.makeConstraints {
            $0.top.equalTo(bakeryOpeningHoursLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        bakeryPhoneNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(bakeryPhoneNumberImage)
            $0.leading.equalTo(bakeryOpeningHoursLabel)
            $0.trailing.equalToSuperview().inset(131)
        }
    }
}
