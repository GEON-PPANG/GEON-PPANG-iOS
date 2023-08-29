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
    
    private var memberData: MyPageResponseDTO = .emptyData() {
        didSet {
            myPageDataSource.memberData = memberData
        }
    }
    private var nickname = ""
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private lazy var myPageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var myPageDataSource = MyPageDataSource(myPageCollectionView, memberData)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden()
        setCollectionViewActions()
        requestMemberData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestMemberData()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        view.addSubview(myPageCollectionView)
        myPageCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        navigationBar.do {
            $0.configureCenterTitle(to: I18N.MyPage.title)
            $0.configureBottomLine()
            $0.hideBackButton(true)
        }
        
        myPageCollectionView.do {
            $0.register(header: MyPageCollectionViewHeader.self)
            $0.register(cell: MyPageCollectionViewCell.self)
            $0.register(footer: MyPageCollectionViewFooter.self)
            $0.dataSource = myPageDataSource.dataSource
            $0.backgroundColor = .gbbGray100
            $0.bounces = false
        }
    }
    
    override func setDelegate() {

        myPageCollectionView.delegate = self
    }
    
    private func setCollectionViewActions() {
        
        myPageDataSource.nextButtonTapped = {
            Utils.push(self.navigationController, FilterViewController(isInitial: false))
        }
        myPageDataSource.myReviewsTapped = {
            Utils.push(self.navigationController, MyReviewsViewController())
        }
        myPageDataSource.savedBakeryTapped = {
            Utils.push(self.navigationController, MySavedBakeryViewController())
        }
    }
    
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
        case 0: return MyPageSectionEnum.basic.items.count
        case 1: return MyPageSectionEnum.version.items.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyPageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let section = indexPath.section
        switch section {
        case 0:
            cell.configureTitle(to: MyPageSectionEnum.basic.items[indexPath.item])
        case 1:
            cell.configureTitle(to: MyPageSectionEnum.version.items[indexPath.item])
        default: return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            let header: MyPageCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.configureMemberData(to: memberData)
            header.nextButtonTapped = {
                Utils.push(self.navigationController, FilterViewController(isInitial: false))
            }
            header.myReviewsTapped = {
                Utils.push(self.navigationController, MyReviewsViewController())
            }
            header.savedBakeryTapped = {
                Utils.push(self.navigationController, MySavedBakeryViewController())
            }
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
        switch indexPath.section {
        case 0:
            return .init(width: SizeLiteral.Screen.width, height: 68 + 8)
        case 1:
            if indexPath.item == 0 {
                return .init(width: SizeLiteral.Screen.width, height: 64)
            } else {
                return .init(width: SizeLiteral.Screen.width, height: 64)
            }
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0:
            let trueOptions = memberData.breadType.configureTrueOptions()
            var letterCount = 0
            trueOptions.forEach { letterCount += $0.0.count }
            return .init(width: collectionView.frame.width,
                         height: letterCount <= 15 ? 288 : 323)
        default:
            return .zero
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

// MARK: - API

extension MyPageViewController {
    
    func requestMemberData() {
        
        MyPageAPI.shared.getMemberData { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            self.memberData = data
            self.myPageDataSource.loadData()
        }
    }
}
