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
    
    private let myPageData = MyPageDTO.dummyData()
    private let username = "빵순이빵돌이"
//    private lazy var myPageTagData = myPageData.breadType.configureTrueOptions()
    
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
    
    private let bookmarkButtonContainer = UIView()
    private let bookmarkButton = ImageWithSubtitleButton(buttonType: .bookmark)
    private let myReviewButtonContainer = UIView()
    private let myReviewButton = ImageWithSubtitleButton(buttonType: .myReview)
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
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(mainTitleLabel)
        mainTitleLabel.snp.makeConstraints {
            // TODO: notch 유무로 재계산
            $0.top.equalToSuperview().inset(44)
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
            $0.leading.equalTo(mainTitleLabel)
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(34)
            $0.size.equalTo(73)
        }
        
        profileImageViewContainer.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        addSubview(purposeFilterChipView)
        purposeFilterChipView.snp.makeConstraints {
            $0.leading.equalTo(profileImageViewContainer.snp.trailing).offset(10)
            $0.top.equalTo(profileImageViewContainer)
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(purposeFilterChipView)
            $0.top.equalTo(purposeFilterChipView.snp.bottom).offset(14)
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
        
        addSubview(bookmarkButtonContainer)
        bookmarkButtonContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalTo(self.snp.centerX)
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(24)
            $0.height.equalTo(87)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        bookmarkButtonContainer.addSubview(bookmarkButton)
        bookmarkButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addSubview(myReviewButtonContainer)
        myReviewButtonContainer.snp.makeConstraints {
            $0.leading.equalTo(bookmarkButtonContainer.snp.trailing)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalTo(bookmarkButtonContainer)
        }
        
        myReviewButtonContainer.addSubview(myReviewButton)
        myReviewButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addSubview(seperatorView)
        seperatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(myReviewButtonContainer)
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
        
        filterCollectionView.do {
            $0.register(cell: DescriptionCollectionViewCell.self)
        }
        
        rightChevronButton.do {
            $0.setImage(.rightArrowIcon, for: .normal)
        }
        
        bookmarkButtonContainer.do {
            $0.roundCorners(corners: [.topLeft, .bottomLeft], radius: 12)
            $0.makeBorder(width: 1, color: .gbbPoint1!)
            $0.backgroundColor = .gbbBackground1
        }
        
        myReviewButtonContainer.do {
            $0.roundCorners(corners: [.topRight, .bottomLeft], radius: 12)
            $0.makeBorder(width: 1, color: .gbbPoint1!)
            $0.backgroundColor = .gbbBackground1
        }
        
        seperatorView.do {
            $0.backgroundColor = .gbbPoint1
        }
    }
    
    private func setDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension MyPageCollectionViewHeader: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension MyPageCollectionViewHeader: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureTagTitle("test")
        return cell
    }
    
}
