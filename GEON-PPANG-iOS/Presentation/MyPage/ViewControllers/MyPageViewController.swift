//
//  MyPageViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class MyPageViewController: BaseViewController {
    
    
    // MARK: - Property
    
    
    // MARK: - UI Property
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var myPageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    // MARK: - Life Cycle
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        Utils.updateCollectionViewConstraint(of: myPageCollectionView)
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(myPageCollectionView)
        myPageCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    override func setUI() {
        flowLayout.do {
            $0.scrollDirection = .vertical
            $0.sectionInset = .init(top: 8, left: 0, bottom: 0, right: 0)
            $0.minimumLineSpacing = 1
        }
        
        myPageCollectionView.do {
            $0.register(header: MyPageCollectionViewHeader.self)
            $0.register(cell: MyPageCollectionViewCell.self)
            $0.register(footer: MyPageCollectionViewFooter.self)
        }
    }
    
    override func setDelegate() {
        myPageCollectionView.delegate = self
        myPageCollectionView.dataSource = self
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    
    
}

// MARK: - UICollectionViewDelegate extension

extension MyPageViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource extension

extension MyPageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MyPageSectionEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return MyPageSectionEnum.terms.items.count
        case 1: return MyPageSectionEnum.questions.items.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyPageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let section = indexPath.section
        switch section {
        case 0: cell.configureTitle(to: MyPageSectionEnum.terms.items[indexPath.item])
        case 1: cell.configureTitle(to: MyPageSectionEnum.questions.items[indexPath.item])
        default: return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            let header: MyPageCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            return header
        case 1:
            let footer: MyPageCollectionViewFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, indexPath: indexPath)
            return footer
        default:
            return UICollectionReusableView()
        }
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout extension

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: SizeLiteral.Screen.width, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(item: 0, section: section)
        let header: MyPageCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
        switch section {
        case 0: return header.systemLayoutSizeFitting(.init(width: collectionView.frame.width,
                                                            height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required,
                                                      verticalFittingPriority: .fittingSizeLevel)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 0: return .zero
        case 1: return .init(width: SizeLiteral.Screen.width, height: 60)
        default: return .zero
        }
    }
    
}
