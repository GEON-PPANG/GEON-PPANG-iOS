//
//  InfoCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

protocol InfoCollectionViewCellDelegate: AnyObject {
    
    func tappedHomepageLinkButton()
    func tappedInstagramLinkButton()
}

final class InfoCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: InfoCollectionViewCellDelegate?
    
    // MARK: - UI Property
    
    private let bakeryLinkImage = UIImageView()
    private lazy var linkButtonStackView = LinkButtonStackView()
    private let bakeryAddressImage = UIImageView()
    private lazy var bakeryAddressLabel = UILabel()
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
        
        contentView.addSubview(bakeryLinkImage)
        bakeryLinkImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
            $0.size.equalTo(24)
        }
        
        contentView.addSubview(linkButtonStackView)
        linkButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(bakeryLinkImage)
            $0.leading.equalTo(bakeryLinkImage.snp.trailing).offset(10)
        }
        
        contentView.addSubview(bakeryAddressImage)
        bakeryAddressImage.snp.makeConstraints {
            $0.top.equalTo(bakeryLinkImage.snp.bottom).offset(18)
            $0.leading.equalTo(bakeryLinkImage)
            $0.size.equalTo(24)
        }
        
        contentView.addSubview(bakeryAddressLabel)
        bakeryAddressLabel.snp.makeConstraints {
            $0.centerY.equalTo(bakeryAddressImage)
            $0.leading.equalTo(linkButtonStackView)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(293)
            $0.height.equalTo(20)
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
        
        bakeryLinkImage.do {
            $0.image = .linkIcon
        }
        
        linkButtonStackView.do {
            $0.homepageLinkButton.do {
                $0.addAction(UIAction { [weak self] _ in
                    self?.tappedHomepageLinkButton()
                }, for: .touchUpInside)
            }
            
            $0.instagramLinkButton.do {
                $0.addAction(UIAction { [weak self] _ in
                    self?.tappedInstagramLinkButton()
                }, for: .touchUpInside)
            }
        }
        
        bakeryAddressImage.do {
            $0.image = .storeIcon
        }
        
        bakeryAddressLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.adjustsFontSizeToFitWidth = true
        }
        
        regionStackView.do {
            $0.configureChipCornerRadius(8)
            $0.configureChipBackgroundColor(.gbbBackground2!)
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
        
        linkButtonStackView.getLinkStatus(data.homepageURL, data.instagramURL)
        bakeryAddressLabel.text = data.address
        regionStackView.configureRegionName(data.firstNearStation, data.secondNearStation)
        
        if data.firstNearStation != "" && data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        
        bakeryClosedDaysLabel.text = data.closedDay
        bakeryOpeningHoursLabel.text = data.openingHours
        bakeryPhoneNumberLabel.text = data.phoneNumber
    }
    
    func tappedHomepageLinkButton() {
        
        delegate?.tappedHomepageLinkButton()
    }
    func tappedInstagramLinkButton() {
        
        delegate?.tappedInstagramLinkButton()
    }
}

// MARK: - Custom Protocol

extension BakeryDetailViewController: InfoCollectionViewCellDelegate {
    
    func tappedHomepageLinkButton() {
        
        AnalyticManager.log(event: .detail(.clickWebsite))
        Utils.push(self.navigationController, WebViewController(url: homepageURL, title: I18N.Detail.homepage))
    }
    
    func tappedInstagramLinkButton() {
        
        AnalyticManager.log(event: .detail(.clickInstagram))
        Utils.push(self.navigationController, WebViewController(url: instagramURL, title: I18N.Detail.instagram))
    }
}
