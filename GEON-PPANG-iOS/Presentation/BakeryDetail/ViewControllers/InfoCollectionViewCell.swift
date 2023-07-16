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
    private lazy var homepageLinkLabel = UILabel()
    private let bakeryAddressImage = UIImageView()
    private let bakeryAddressLabel = UILabel()
    private lazy var addressCopyButton = UIButton()
    private let regionStackView = RegionStackView()
    private let bakeryOpeningHoursImage = UIImageView()
    private let bakeryClosedDaysLabel = UILabel()
    private let bakeryOpeningHoursLabel = UILabel()
    private let bakeryPhoneNumberImage = UIImageView()
    private let bakeryPhoneNumberLabel = UILabel()
    
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
        
        homepageLinkLabel.do {
            $0.basic(text: "https://www.naver.com/mmv_vegan_bake_shop/", font: .subHead!, color: .gbbGray400!)
            $0.numberOfLines = 2
        }
        
        bakeryAddressImage.do {
            $0.image = .storeIcon
        }
        
        bakeryAddressLabel.do {
            $0.basic(text: "경기 의왕시 신장승길 29 퍼스트힐5차 111호", font: .subHead!, color: .gbbGray400!)
            $0.numberOfLines = 2
        }
        
        addressCopyButton.do {
            $0.setImage(.copyButton, for: .normal)
        }
        
        regionStackView.do {
            $0.backgroundColor = .clear
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
        
        contentView.addSubviews(homepageLinkImage, homepageLinkLabel, bakeryAddressImage, bakeryAddressLabel, addressCopyButton, regionStackView, bakeryOpeningHoursImage, bakeryClosedDaysLabel, bakeryOpeningHoursLabel, bakeryPhoneNumberImage, bakeryPhoneNumberLabel)
        
        homepageLinkImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        homepageLinkLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(homepageLinkImage.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
        }
        
        bakeryAddressImage.snp.makeConstraints {
            // TODO: 2줄이면 URL 기준 18만큼 아래, 1줄이면 아이콘 기준 18만큼 아래로
            $0.top.equalTo(homepageLinkImage.snp.bottom).offset(34)
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        bakeryAddressLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryAddressImage)
            $0.leading.equalTo(homepageLinkLabel)
            $0.trailing.equalTo(addressCopyButton.snp.leading).offset(36)
        }
        
        addressCopyButton.snp.makeConstraints {
            $0.top.equalTo(bakeryAddressImage)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryAddressLabel.snp.bottom).offset(8)
            $0.leading.equalTo(bakeryAddressLabel)
        }
        
        bakeryOpeningHoursImage.snp.makeConstraints {
            $0.top.equalTo(regionStackView.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        bakeryClosedDaysLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryOpeningHoursImage)
            $0.leading.equalTo(regionStackView)
        }
        
        bakeryOpeningHoursLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryClosedDaysLabel.snp.bottom).offset(2)
            $0.leading.equalTo(bakeryClosedDaysLabel)
            $0.trailing.equalToSuperview()
        }
        
        bakeryPhoneNumberImage.snp.makeConstraints {
            $0.top.equalTo(bakeryOpeningHoursLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        bakeryPhoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryPhoneNumberImage)
            $0.leading.equalTo(bakeryOpeningHoursLabel)
            $0.trailing.equalToSuperview().inset(155)
        }
    }
}
