//
//  MyPageCollectionViewHeader.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyPageProfileCell: UICollectionViewCell {
    
    // MARK: - Prperty
    
    private var myPageData = MyPageResponseDTO.dummyData()
    private lazy var myPageTagData = myPageData.breadType.configureTrueOptions()
    var filterButtonTapped: (() -> Void)?
    var savedBakeryTapped: (() -> Void)?
    var myReviewsTapped: (() -> Void)?
    
    // MARK: - UI Property
    
    private let profileImageView = UIImageView(image: .smileIcon86px)
    private let purposeFilterChipView = MyPagePurposeChipView()
    private let userNameLabel = UILabel()
    private let flowLayout = OptionsCollectionViewFlowLayout()
    lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let filterButton = UIButton()
    
    private let buttonsContainer = UIView()
    private let bookmarkButton = ImageWithSubtitleButton(buttonType: .bookmark)
    private let myReviewButton = ImageWithSubtitleButton(buttonType: .myReview)
    private lazy var buttonsStackView = UIStackView(arrangedSubviews: [bookmarkButton, myReviewButton])
    private let seperatorView = UIView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateHeight()
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.leading.equalToSuperview().inset(24)
        }
        
        self.addSubview(purposeFilterChipView)
        purposeFilterChipView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(14)
            $0.top.equalTo(profileImageView)
        }
        
        self.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(purposeFilterChipView)
            $0.top.equalTo(purposeFilterChipView.snp.bottom).offset(8)
            $0.height.equalTo(25)
        }
        
        self.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.leading.equalTo(purposeFilterChipView)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(56)
            $0.width.equalTo(180)
        }
        
        self.addSubview(filterButton)
        filterButton.snp.makeConstraints {
            $0.top.equalTo(purposeFilterChipView)
            $0.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(filterCollectionView)
            $0.width.equalTo(48)
        }
        
        self.addSubview(buttonsContainer)
        buttonsContainer.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(87)
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(36)
        }
        
        buttonsContainer.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        buttonsContainer.addSubview(seperatorView)
        seperatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(42)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        userNameLabel.do {
            $0.font = .title2
            $0.textColor = .gbbGray700
        }
        
        flowLayout.do {
            $0.minimumLineSpacing = 6
            $0.minimumInteritemSpacing = 4
        }
        
        filterCollectionView.do {
            $0.register(cell: DescriptionCollectionViewCell.self)
        }
        
        filterButton.do {
            $0.setImage(.rightArrowIcon, for: .normal)
            $0.addAction(UIAction { _ in
                self.filterButtonTapped?()
            }, for: .touchUpInside)
        }
        
        buttonsContainer.do {
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbPoint1!)
            $0.backgroundColor = .gbbBackground1
        }
        
        buttonsStackView.do {
            $0.axis = .horizontal
            $0.spacing = CGFloat().convertByWidthRatio(96)
        }
        
        seperatorView.do {
            $0.backgroundColor = .gbbPoint1
        }
        
        bookmarkButton.do {
            $0.configureButtonAction {
                self.savedBakeryTapped?()
            }
        }
        
        myReviewButton.do {
            $0.configureButtonAction {
                self.myReviewsTapped?()
            }
        }
    }
    
    private func setDelegate() {
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    // MARK: - Custom Method
    
    func configureMemberData(to memberData: MyPageResponseDTO) {
        
        self.myPageData = memberData
        self.purposeFilterChipView.configureChip(toTag: convertFromData(myPageData.mainPurpose))
        self.userNameLabel.text = memberData.memberNickname
        self.myPageTagData = memberData.breadType.configureTrueOptions()
        
        filterCollectionView.reloadData()
    }
    
    func convertFromData(_ data: String) -> FilterPurposeType? {
        
        switch data {
        case "HEALTH": return .health
        case "DIET": return .diet
        case "VEGAN": return .vegan
        default: return nil
        }
    }
    
    private func updateHeight() {
        
        filterCollectionView.snp.updateConstraints {
            $0.height.equalTo(chipCount() < 4 ? 25 : 50)
        }
    }
    
    private func chipCount() -> Int {
        
        return myPageData.breadType.configureTrueOptions().count
    }
}

// MARK: - UICollectionViewDelegate extension

extension MyPageProfileCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource extension

extension MyPageProfileCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myPageTagData.filter { $0.1 == true }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureTagTitle(myPageTagData[indexPath.item].0)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout extension

extension MyPageProfileCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dummyLabel = UILabel()
        dummyLabel.do {
            $0.text = myPageTagData[indexPath.item].0
            $0.font = .captionM1
        }
        let size = dummyLabel.intrinsicContentSize
        return .init(width: size.width + 12, height: size.height + 8)
    }
    
}
