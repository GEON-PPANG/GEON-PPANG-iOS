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
    
    private let homepageLinkImage = UIImageView()
    private let homepageLinkButton = UIButton()
    private let bakeryAddressImage = UIImageView()
    private lazy var bakeryAddressLabel = UILabel()
    private lazy var addressCopyButton = UIButton()
    private lazy var regionStackView = RegionStackView()
    private let bakeryOpeningHoursImage = UIImageView()
    private let bakeryClosedDaysLabel = UILabel()
    private let bakeryOpeningHoursLabel = UILabel()
    private let bakeryPhoneNumberImage = UIImageView()
    private let bakeryPhoneNumberLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
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
        
        contentView.addSubview(homepageLinkImage)
        homepageLinkImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
            $0.size.equalTo(24)
        }
        
        contentView.addSubview(homepageLinkButton)
        homepageLinkButton.snp.makeConstraints {
            $0.centerY.equalTo(homepageLinkImage)
            $0.leading.equalTo(homepageLinkImage.snp.trailing).offset(10)
            $0.width.equalTo(95)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(bakeryAddressImage)
        bakeryAddressImage.snp.makeConstraints {
            $0.top.equalTo(homepageLinkImage.snp.bottom).offset(18)
            $0.leading.equalTo(homepageLinkImage)
            $0.size.equalTo(24)
        }
        
        contentView.addSubview(bakeryAddressLabel)
        bakeryAddressLabel.snp.makeConstraints {
            $0.centerY.equalTo(bakeryAddressImage)
            $0.leading.equalTo(homepageLinkButton)
            $0.trailing.equalToSuperview().inset(68)
            $0.width.equalTo(249)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(addressCopyButton)
        addressCopyButton.snp.makeConstraints {
            $0.centerY.equalTo(bakeryAddressImage)
            $0.trailing.equalToSuperview().inset(24)
            $0.size.equalTo(30)
        }
        
        contentView.addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryAddressLabel.snp.bottom).offset(13)
            $0.leading.equalTo(bakeryAddressLabel)
        }
        
        contentView.addSubview(bakeryOpeningHoursImage)
        bakeryOpeningHoursImage.snp.makeConstraints {
            $0.top.equalTo(regionStackView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(24)
        }
        
        contentView.addSubview(bakeryClosedDaysLabel)
        bakeryClosedDaysLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryOpeningHoursImage)
            $0.leading.equalTo(bakeryAddressLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(293)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(bakeryOpeningHoursLabel)
        bakeryOpeningHoursLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryClosedDaysLabel.snp.bottom).offset(2)
            $0.leading.equalTo(bakeryClosedDaysLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(293)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(bakeryPhoneNumberImage)
        bakeryPhoneNumberImage.snp.makeConstraints {
            $0.top.equalTo(bakeryOpeningHoursLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(24)
        }
        
        contentView.addSubview(bakeryPhoneNumberLabel)
        bakeryPhoneNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(bakeryPhoneNumberImage)
            $0.leading.equalTo(bakeryOpeningHoursLabel)
            $0.trailing.equalToSuperview().inset(155)
            $0.width.equalTo(162)
            $0.height.equalTo(20)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        homepageLinkImage.do {
            $0.image = .linkIcon
        }
        
        // TODO: 클릭 시 사파리로 이동 (API 통신 필요)
        homepageLinkButton.do {
            $0.setTitle("홈페이지로 이동", for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.setUnderline()
            $0.titleLabel?.font = .subHead
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        
        bakeryAddressImage.do {
            $0.image = .storeIcon
        }
        
        bakeryAddressLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.adjustsFontSizeToFitWidth = true
        }
        
        addressCopyButton.do {
            $0.setImage(.copyButton, for: .normal)
        }
        
        bakeryOpeningHoursImage.do {
            $0.image = .timeIcon
        }
        
        bakeryClosedDaysLabel.do {
            $0.basic(font: .subHead!, color: .gbbError!)
        }
        
        bakeryOpeningHoursLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.adjustsFontSizeToFitWidth = true
        }
        
        bakeryPhoneNumberImage.do {
            $0.image = .callIcon
        }
        
        bakeryPhoneNumberLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
        }
    }
    
    // MARK: - Custom Method
    
    func configureCellUI(_ data: BakeryDetailResponseDTO) {
        
        bakeryAddressLabel.text = data.address
        regionStackView.configureRegionName(data.firstNearStation, data.secondNearStation)
        
        if data.firstNearStation != "" && data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        
        bakeryClosedDaysLabel.text = data.closedDay
        bakeryOpeningHoursLabel.text = data.openingTime
        bakeryPhoneNumberLabel.text = data.phoneNumber
    }
}
