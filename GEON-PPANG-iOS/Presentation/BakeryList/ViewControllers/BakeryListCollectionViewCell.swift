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
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
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
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, bakeryTitle, regionStackView)
        bakeryImage.addSubview(markStackView)
        
        bakeryImage.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.height.equalTo(22)
        }

        bakeryTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
        }
        
        regionStackView.snp.makeConstraints {
            $0.height.equalTo(29)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(24)
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
    
    func updateUI(data: BakeryListResponseDTO, index: Int) {
        self.index = index
        bakeryTitle.text = data.bakeryName
        bookMarkButton.getCount(data.bookmarkCount)
        bookMarkButton.updateData = { [weak self] status in
            guard let self = self  else { return }
            self.updateData?(status, self.index)
        }
        bookMarkButton.isSelected = data.isBooked ? true : false
        markStackView.getMarkStatus(data.isHACCP, data.isVegan, data.isNonGMO)
        if data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.getRegionName(data.firstNearStation, data.secondNearStation ?? "")
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
    
    func reviewViewButton() {
        addSubview(arrowButton)
        
        regionStackView.getBackgroundColor(.gbbGray700!)
        arrowButton.do {
            $0.setImage(.rightArrowIcon, for: .normal)
            $0.addAction(UIAction { _ in
                print("review")
            }, for: .touchUpInside)
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
