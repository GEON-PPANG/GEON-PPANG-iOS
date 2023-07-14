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
    private lazy var myPageTagData = myPageData.breadType.configureTrueOptions()
    
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
        
        Utils.updateCollectionViewConstraint(of: filterCollectionView)
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
        
        addSubview(buttonsContainer)
        buttonsContainer.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(24)
            $0.height.equalTo(87)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.center.equalTo(buttonsContainer)
        }
        
        addSubview(seperatorView)
        seperatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(buttonsContainer)
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
        
        flowLayout.do {
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 4
        }
        
        filterCollectionView.do {
            $0.register(cell: DescriptionCollectionViewCell.self)
        }
        
        rightChevronButton.do {
            $0.setImage(.rightArrowIcon, for: .normal)
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
    }
    
    private func setDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
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
