//
//  MyPageCollectionViewHeader.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyPageCollectionViewHeader: UICollectionReusableView {
    
    // MARK: - Prperty
    
    private var myPageData = MyPageResponseDTO.dummyData()
    private lazy var username = myPageData.memberNickname
    private lazy var myPageTagData = myPageData.breadType.configureTrueOptions()
    var nextButtonTapped: (() -> Void)?
    var savedBakeryTapped: (() -> Void)?
    var myReviewsTapped: (() -> Void)?
    
    // MARK: - UI Property
    
    private let mainTitleLabel = UILabel()
    private let mainTitleLogoImageView = UIImageView(image: .enabledStorelistIcon)
    private let profileImageViewContainer = UIView()
    private let profileImageView = UIImageView(image: .profileIcon)
    private let purposeFilterChipView = MyPagePurposeChipView()
    private let userNameLabel = UILabel()
    private let flowLayout = OptionsCollectionViewFlowLayout()
    lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let rightChevronButton = UIButton()
    
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
        
//        Utils.updateCollectionViewConstraint(of: filterCollectionView, byOffset: 1)
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(mainTitleLabel)
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(CGFloat().heightConsideringNotch(44))
            $0.leading.equalToSuperview().inset(24)
        }
        
        addSubview(mainTitleLogoImageView)
        mainTitleLogoImageView.snp.makeConstraints {
            $0.leading.equalTo(mainTitleLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(mainTitleLabel)
            $0.size.equalTo(24)
        }
        
        addSubview(profileImageViewContainer)
        profileImageViewContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(34)
            $0.size.equalTo(73)
        }
        
        profileImageViewContainer.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(36.5)
            $0.width.equalTo(35.5)
        }
        
        addSubview(purposeFilterChipView)
        purposeFilterChipView.snp.makeConstraints {
            $0.leading.equalTo(profileImageViewContainer.snp.trailing).offset(10)
            $0.top.equalTo(profileImageViewContainer)
            $0.height.equalTo(25)
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(purposeFilterChipView)
            $0.top.equalTo(purposeFilterChipView.snp.bottom).offset(14)
            $0.height.equalTo(25)
        }
        
        addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.leading.equalTo(purposeFilterChipView)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(60)
            $0.width.equalTo(170)
        }
        
        addSubview(rightChevronButton)
        rightChevronButton.snp.makeConstraints {
            $0.top.equalTo(purposeFilterChipView)
            $0.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(filterCollectionView)
            $0.width.equalTo(48)
        }
        
        addSubview(buttonsContainer)
        buttonsContainer.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(87)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.center.equalTo(buttonsContainer)
        }
        
        addSubview(seperatorView)
        seperatorView.snp.makeConstraints {
            $0.center.equalTo(buttonsContainer)
            $0.width.equalTo(1)
            $0.height.equalTo(42)
        }
    }
    
    private func setUI() {
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        mainTitleLabel.do {
            $0.text = I18N.MyPage.title
            $0.font = .title1
            $0.textColor = .gbbGray700
        }
        
        profileImageViewContainer.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeCornerRound(radius: 36.5)
        }
        
        userNameLabel.do {
            $0.text = username
            $0.font = .title2
            $0.textColor = .gbbGray700
        }
        
        purposeFilterChipView.do {
            $0.configureChip(toTag: .vegan)
        }
        
        flowLayout.do {
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 4
        }
        
        filterCollectionView.do {
            $0.register(cell: DescriptionCollectionViewCell.self)
        }
        
        rightChevronButton.do {
            $0.setImage(.rightArrowIcon, for: .normal)
            $0.addAction(UIAction { _ in
                self.nextButtonTapped?()
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
            $0.addButtonAction {
                self.savedBakeryTapped?()
            }
        }
        
        myReviewButton.do {
            $0.addButtonAction {
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
    
    func convertFromData(_ data: String) -> FilterPurposeType {
        switch data {
        case "HEALTH": return .health
        case "DIET": return .diet
        case "VEGAN": return .vegan
        default: return .health
        }
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension MyPageCollectionViewHeader: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource extension

extension MyPageCollectionViewHeader: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPageTagData.filter { $0.1 == true }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureTagTitle(myPageTagData[indexPath.item].0)
        return cell
    }
    
}
