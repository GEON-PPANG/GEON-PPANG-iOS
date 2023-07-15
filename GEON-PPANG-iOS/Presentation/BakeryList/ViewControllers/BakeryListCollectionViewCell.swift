//
//  BakeryListCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

enum BakeryViewType {
    case defaultType
    case reviewType
}

final class BakeryListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    var index = 0
    var updateData: ((Bool, Int) -> Void)?
    private var breadTypeTag: [String] = []
    private var ingredientList: [BakeryListResponseDTO] = BakeryListResponseDTO.item
    private var bakeryViewType: BakeryViewType? = .defaultType {
        didSet {
            configure()
        }
    }
    
    // MARK: - UI Property
    
    private let markStackView = MarkStackView()
    private let bakeryImage = UIImageView()
    private let bakeryTitle = UILabel()
    private let regionStackView = RegionStackView()
    private lazy var bookMarkButton = BookmarkButton(configuration: .plain())
    private lazy var arrowButton = UIButton()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
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
            $0.backgroundColor = .darkGray
            $0.makeCornerRound(radius: 5)
        }
        markStackView.do {
            $0.getIconImage(.smallHACCPMark, .smallVeganMark, .smallGMOMark)
        }
        bakeryTitle.do {
            $0.basic(font: .pretendardBold(20), color: .gbbGray700!)
        }
        collectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, bakeryTitle, collectionView, regionStackView)
        bakeryImage.addSubview(markStackView)
        
        bakeryImage.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().inset(48)
        }
        
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.width.equalTo(55)
            $0.height.equalTo(22)
        }
        
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.top)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(16)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().offset(-70)
        }
        
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.height.equalTo(29)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
    
    func updateUI<T: BakeryListProtocol>(data: T, index: Int) {
        self.index = index
        bakeryTitle.text = data.bakeryName
        bookMarkButton.getCount(data.bookmarkCount)
        bookMarkButton.updateData = { [weak self] status in
            guard let self = self else { return }
            self.updateData?(status, self.index)
        }
        bookMarkButton.isSelected = data.isBooked
        markStackView.getMarkStatus(data.isHACCP, data.isVegan, data.isNonGMO)
        if data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.getRegionName(data.firstNearStation, data.secondNearStation ?? "")

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

        collectionView.snp.remakeConstraints {
            $0.height.equalTo(getHeight(breadTypeTag))
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(10)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().offset(-70)
        }
    }

    func getViewType(_ type: BakeryViewType) {
        bakeryViewType = type
    }

    func defaultViewButton() {
        addSubview(bookMarkButton)

        bookMarkButton.do {
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.top
            $0.configuration?.imagePadding = 4
            $0.configuration?.contentInsets = .zero
            $0.addAction(UIAction { _ in
                print("default")
            }, for: .touchUpInside)
        }

        bookMarkButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
            $0.size.equalTo(34)
        }
    }

    func getHeight(_ list: [String]) -> CGFloat {
        var width: CGFloat = 0
        list.forEach {
            width += $0.size(withAttributes: [NSAttributedString.Key.font: UIFont.pretendardMedium(13)]).width + 4
        }
        width -= 4

        return width < (UIScreen.main.bounds.width - 206) ? 25 : 60
    }

    func reviewViewButton() {
        addSubview(arrowButton)

        regionStackView.getBackgroundColor(.gbbGray700!)
        arrowButton.do {
            $0.setImage(.rightArrowIcon, for: .normal)
            $0.addAction(UIAction { _ in
                print("review")
            }, for: .touchUpInside)
        }
        
        bakeryImage.snp.remakeConstraints {
            $0.size.equalTo(90)
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(24)
        }
        arrowButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-12)
            $0.size.equalTo(23)
        }
    }
    
    func configure() {
        switch bakeryViewType {
        case .defaultType:
            defaultViewButton()
        case .reviewType:
            reviewViewButton()
        case .none:
            return
        }
    }
}

// MARK: - CollectionView Register

extension BakeryListCollectionViewCell {
    private func setRegistration() {
        collectionView.register(cell: DescriptionCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension BakeryListCollectionViewCell: UICollectionViewDataSource {
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

extension BakeryListCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagTitle = self.breadTypeTag[indexPath.item]
        let itemSize = tagTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.pretendardMedium(13)])
        return CGSize(width: itemSize.width + 12, height: itemSize.height + 8)
    }
}
