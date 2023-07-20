//
//  DetailBottomView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/20.
//

import UIKit

import SnapKit
import Then

final class DetailBottomView: UIView {
    
    // MARK: - Property
    
    var isBookmarked: Bool = false {
        didSet {
            configureBookmarkButton(to: isBookmarked)
        }
    }
    var tappedBookmarkButton: (() -> Void)?
    var tappedWriteReviewButton: (() -> Void)?
    
    // MARK: - UI Property
    
    private lazy var bookmarkButton = UIButton()
    
    private let writeReviewButtonImage = UIImageView(image: .logoIcon16px)
    private let writeReviewButtonTitle = UILabel()
    private lazy var writeReviewButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
        setShadow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(CGFloat().heightConsideringBottomSafeArea(126))
        }
        
        addSubview(bookmarkButton)
        bookmarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(48)
        }
        
        addSubview(writeReviewButton)
        writeReviewButton.snp.makeConstraints {
            $0.centerY.equalTo(bookmarkButton)
            $0.leading.equalTo(bookmarkButton.snp.trailing).offset(32)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        writeReviewButton.addSubview(writeReviewButtonImage)
        writeReviewButtonImage.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalToSuperview().inset(74.5)
            $0.centerY.equalToSuperview()
        }
        
        writeReviewButton.addSubview(writeReviewButtonTitle)
        writeReviewButtonTitle.snp.makeConstraints {
            $0.leading.equalTo(writeReviewButtonImage.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setUI() {
        bookmarkButton.do {
            $0.setImage(.disabledBookmarkButton.resize(to: .init(width: 48, height: 48)), for: .normal)
            $0.addAction(UIAction { _ in
                self.tappedBookmarkButton?()
            }, for: .touchUpInside)
        }
        
        writeReviewButton.do {
            $0.backgroundColor = .gbbPoint1
            $0.makeCornerRound(radius: 24)
            $0.addAction(UIAction { _ in
                self.tappedWriteReviewButton?()
            }, for: .touchUpInside)
        }
        
        writeReviewButtonTitle.do {
            $0.text = I18N.Detail.writeReview
            $0.font = .bodyB2
            $0.textColor = .gbbWhite
        }
    }

    private func setShadow() {
        self.layer.applyShadow(color: .init(red: 0, green: 0, blue: 0, alpha: 0.1),
                               alpha: 1,
                               x: 0,
                               y: 1,
                               blur: 10)
    }
    
    // MARK: - Custom Method
    
    func configureBookmarkButton(to isSelected: Bool) {
        bookmarkButton.do {
            $0.setImage((isSelected ? UIImage.enabledBookmarkButton : UIImage.disabledBookmarkButton).resize(to: .init(width: 48, height: 48)), for: .normal)
        }
    }
    
}


//var isBookmarked: Bool = false

//private let detailBottomView = DetailBottomView()


//view.addSubview(detailBottomView)
//detailBottomView.snp.makeConstraints {
//    $0.bottom.equalToSuperview().inset(300)
//    $0.horizontalEdges.equalToSuperview()
//}



//detailBottomView.do {
//    $0.backgroundColor = .white
//    $0.tappedBookmarkButton = {
//        self.detailBottomView.isBookmarked.toggle()
//        self.requestBakeryBookmark(self.isBookmarked)
//    }
//    $0.tappedWriteReviewButton = {
//        Utils.push(self.navigationController, WriteReviewViewController())
//    }
//}


//extension MyPageViewController {
//    func requestBakeryBookmark(_ value: Bool) {
//        let bookmarkRequest = BookmarkRequestDTO(isAddingBookMark: value)
//        BakeryAPI.shared.postBookmark(bakeryID: 3, with: bookmarkRequest) { response in
//            dump(response)
//        }
//        isBookmarked.toggle()
//    }
//}
