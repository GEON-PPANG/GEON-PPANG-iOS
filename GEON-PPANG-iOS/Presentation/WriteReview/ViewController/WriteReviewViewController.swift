//
//  WriteReviewViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - Property
    
    private var likeCollectionViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - UI Property
    
    // TODO: ScrollView 추가
    // TODO: navigationBar 추가
    // TODO: bakeryImage 추가
    private let bakeryOverviewView = BakeryOverviewView(bakeryImage: .actions, regions: ["tset", "efqerqf"])
    private let lineView = LineView()
    private let likeCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private let optionsCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private lazy var likeCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: likeCollectionViewFlowLayout)
    private lazy var optionsCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: optionsCollectionViewFlowLayout)
    private let reviewDetailTextView = ReviewDetailTextView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: baseVC 에 숨기기
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateCollectionViewConstraint(of: likeCollectionView)
        updateCollectionViewConstraint(of: optionsCollectionView)
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(bakeryOverviewView)
        bakeryOverviewView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(125)
        }
        
        view.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(bakeryOverviewView.snp.bottom)
            $0.height.equalTo(1)
        }
        
        view.addSubview(likeCollectionView)
        likeCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(73)
        }
        
        view.addSubview(optionsCollectionView)
        optionsCollectionView.snp.makeConstraints {
            $0.top.equalTo(likeCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
        
        view.addSubview(reviewDetailTextView)
        reviewDetailTextView.snp.makeConstraints {
            $0.top.equalTo(optionsCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    override func setUI() {
        likeCollectionViewFlowLayout.do {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        optionsCollectionViewFlowLayout.do {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        optionsCollectionView.do {
            $0.allowsMultipleSelection = true
        }
    }
    
    override func setDelegate() {
        likeCollectionView.delegate = self
        likeCollectionView.dataSource = self
        
        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
        
        reviewDetailTextView.detailTextView.delegate = self
    }
    
    // MARK: - Custom Method
    
    private func updateCollectionViewConstraint(of collectionView: UICollectionView) {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        guard height != 0 else { return }
        collectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
}

// MARK: - extension

extension WriteReviewViewController: UICollectionViewDelegate {}

extension WriteReviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case likeCollectionView: return 2
        case optionsCollectionView: return 4
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionsCollectionViewCell.identifier, for: indexPath) as? OptionsCollectionViewCell
        else { return UICollectionViewCell() }
        
        switch collectionView {
        case likeCollectionView:
            cell.configureCell(to: .deselected)
            cell.configureCellText(to: indexPath.item == 0 ? "좋아요" : "별로에요")
        case optionsCollectionView:
            let keywordList = KeywordList.Keyword.allCases.map { $0.rawValue }
            cell.configureCell(to: .disabled)
            cell.configureCellText(to: keywordList[indexPath.item])
            cell.isUserInteractionEnabled = false
        default: return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OptionsCollectionViewHeader.identifier, for: indexPath) as? OptionsCollectionViewHeader
        else { return UICollectionReusableView() }
        
        switch collectionView {
        case likeCollectionView:
            header.configureTitle(to: "건빵집은 어떠셨나요?")
        case optionsCollectionView:
            header.configureTitle(to: "어떤것을 추천하나요?")
        default:
            return UICollectionReusableView()
        }
        return header
    }
    
}

extension WriteReviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 22)
    }
}

extension WriteReviewViewController: UITextViewDelegate {
    
    
}
