//
//  BakeryListCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class BakeryCollectionViewListCell: UICollectionViewListCell {
    
    // MARK: - Property
    
    var updateData: ((Bool, Int) -> Void)?
    private var breadTypeTag: [String] = []
    private var ingredientList: [BakeryListResponseDTO] = []
    
    // MARK: - UI Property
    
    private let markStackView = MarkStackView()
    private let bakeryImage = UIImageView()
    private let bakeryTitle = UILabel()
    private let regionStackView = RegionStackView()
    private let reviewStacView = UIStackView()
    private let reviewIcon = UIImageView()
    private let reviewCount = UILabel()
    private lazy var arrowButton = UIButton()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ingredientList = []
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        setRegistration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        self.do {
            $0.contentView.backgroundColor = .white
        }
        
        bakeryImage.do {
            $0.makeCornerRound(radius: 5)
        }
        
        markStackView.do {
            $0.getIconImage(.smallHACCPMark, .smallVeganMark, .smallGMOMark)
        }
        
        bakeryTitle.do {
            $0.basic(font: .title2!, color: .gbbGray700!)
        }
        
        collectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
        }
        
        reviewStacView.do {
            $0.addArrangedSubviews(reviewIcon, reviewCount)
            $0.axis = .horizontal
            $0.spacing = 1
        }
        
        reviewIcon.do {
            $0.image = .bookmarkIcon16px400
            $0.contentMode = .scaleAspectFit
        }
        
        reviewCount.do {
            $0.basic(font: .captionB1!, color: .gbbGray400!)
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, bakeryTitle, collectionView, regionStackView, reviewStacView)
        bakeryImage.addSubview(markStackView)
        
        bakeryImage.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.size.equalTo(CGSize(width: 55, height: 22))
        }
        
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.top)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(8)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.height.equalTo(29)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        reviewStacView.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.top)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(16)
        }
        
        reviewIcon.snp.makeConstraints {
            $0.size.equalTo(16)
        }
    }
    
    func updateUI<T: BakeryListProtocol>(data: T) {
        bakeryTitle.setLineHeight(by: 1.05, with: data.bakeryName)
        reviewCount.setLineHeight(by: 1.1, with: "(\(data.reviewCount))")
        guard let url = URL(string: data.bakeryPicture) else { return }
        bakeryImage.kf.setImage(with: url)
        markStackView.getMarkStatus(data.isHACCP, data.isVegan, data.isNonGMO)
        if data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.getRegionName(data.firstNearStation, data.secondNearStation ?? "")
        
        breadTypeTag = []
        if data.breadType.isGlutenFree {
            breadTypeTag.append(I18N.BakeryList.glutenfree)
        }
        
        if data.breadType.isNutFree {
            breadTypeTag.append(I18N.BakeryList.nutfree)
        }
        
        if data.breadType.isVegan {
            breadTypeTag.append(I18N.BakeryList.vegan)
        }
        
        if data.breadType.isSugarFree {
            breadTypeTag.append(I18N.BakeryList.noSugar)
        }
        
        collectionView.reloadData()
        
        collectionView.snp.remakeConstraints {
            $0.height.equalTo(Utils.getHeight(breadTypeTag))
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(10)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
}

// MARK: - CollectionView Register

extension BakeryCollectionViewListCell {
    private func setRegistration() {
        collectionView.register(cell: DescriptionCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension BakeryCollectionViewListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breadTypeTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureTagTitle(self.breadTypeTag[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BakeryCollectionViewListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagTitle = self.breadTypeTag[indexPath.item]
        let itemSize = tagTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.captionM1])
        return CGSize(width: itemSize.width + 12, height: itemSize.height + 8)
    }
}
