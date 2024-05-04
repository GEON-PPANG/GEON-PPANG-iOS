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
    
    private let infoStackView = UIStackView()
    
    private let linkSection = UIView()
    private let linkImage = UIImageView()
    private lazy var linkButtonStackView = LinkButtonStackView()
    
    private let addressSection = UIView()
    private let addressImage = UIImageView()
    private lazy var addressLabel = UILabel()
    private lazy var regionStackView = RegionStackView()
    
    private let openingHoursSection = UIView()
    private let openingHoursImage = UIImageView()
    private let closedDaysLabel = UILabel()
    private let openingHoursLabel = UILabel()
    
    private let phoneNumberSection = UIView()
    private let phoneNumberImage = UIImageView()
    private let phoneNumberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        contentView.addSubview(infoStackView)
        infoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
        
        infoStackView.addArrangedSubview(linkSection)
        linkSection.addSubview(linkImage)
        linkImage.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.size.equalTo(24)
        }
        linkSection.addSubview(linkButtonStackView)
        linkButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(linkImage)
            $0.leading.equalTo(linkImage.snp.trailing).offset(10)
        }
        
        infoStackView.addArrangedSubview(addressSection)
        addressSection.addSubview(addressImage)
        addressImage.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.size.equalTo(24)
        }
        addressSection.addSubview(addressLabel)
        addressLabel.snp.makeConstraints {
            $0.centerY.equalTo(addressImage)
            $0.leading.equalTo(addressImage.snp.trailing).offset(10)
        }
        addressSection.addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.leading.equalTo(addressImage.snp.trailing).offset(10)
            $0.top.equalTo(addressImage.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        
        infoStackView.addArrangedSubview(openingHoursSection)
        openingHoursSection.addSubview(openingHoursImage)
        openingHoursImage.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.size.equalTo(24)
        }
        openingHoursSection.addSubview(closedDaysLabel)
        closedDaysLabel.snp.makeConstraints {
            $0.leading.equalTo(openingHoursImage.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        openingHoursSection.addSubview(openingHoursLabel)
        openingHoursLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(closedDaysLabel)
            $0.top.equalTo(closedDaysLabel.snp.bottom).offset(2)
            $0.bottom.equalToSuperview()
        }
        
        infoStackView.addArrangedSubview(phoneNumberSection)
        phoneNumberSection.addSubview(phoneNumberImage)
        phoneNumberImage.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.size.equalTo(24)
        }
        phoneNumberSection.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(phoneNumberImage)
            $0.leading.equalTo(phoneNumberImage.snp.trailing).offset(10)
        }
    }
    
    private func setUI() {
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        infoStackView.do {
            $0.axis = .vertical
            $0.spacing = 18
            $0.distribution = .equalSpacing
        }
        
        linkImage.do {
            $0.image = .Icon.link
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
        
        addressImage.do {
            $0.image = .Icon.store
        }
        
        addressLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400)
            $0.adjustsFontSizeToFitWidth = true
        }
        
        regionStackView.do {
            $0.configureChipCornerRadius(8)
            $0.configureChipBackgroundColor(.gbbBackground2)
        }
        
        openingHoursImage.do {
            $0.image = .Icon.time
        }
        
        closedDaysLabel.do {
            $0.basic(font: .subHead!, color: .gbbError)
        }
        
        openingHoursLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400)
            $0.adjustsFontSizeToFitWidth = true
        }
        
        phoneNumberImage.do {
            $0.image = .Icon.call
        }
        
        phoneNumberLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400)
        }
    }
    
    func configureCellUI(_ data: BakeryDetailResponseDTO) {
        
        if data.homepageURL == "" && data.instagramURL == "" {
            linkSection.isHidden = true
        } else {
            linkSection.isHidden = false
            linkButtonStackView.getLinkStatus(data.homepageURL, data.instagramURL)
        }
        addressLabel.text = data.address
        regionStackView.configureRegionName(data.firstNearStation, data.secondNearStation)
        
        if data.firstNearStation != "" && data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        
        closedDaysLabel.text = data.closedDay
        openingHoursLabel.text = data.openingHours
        phoneNumberLabel.text = data.phoneNumber
    }
    
    func tappedHomepageLinkButton() {
        
        delegate?.tappedHomepageLinkButton()
    }
    func tappedInstagramLinkButton() {
        
        delegate?.tappedInstagramLinkButton()
    }
}

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
