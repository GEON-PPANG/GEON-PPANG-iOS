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
        
        myPageDataSource.filterButtonTapped = {
            Utils.push(self.navigationController, FilterViewController(isInitial: false))
        }
        myPageDataSource.myReviewsTapped = {
            Utils.push(self.navigationController, MyReviewsViewController())
        }
        myPageDataSource.savedBakeryTapped = {
            Utils.push(self.navigationController, MySavedBakeryViewController())
        }
        
        myPageDataSource.logoutTapped = {
            self.showPopUp(of: .logout)
        }
        myPageDataSource.leaveTapped = {
            self.showPopUp(of: .leave)
        }
    }
    
    // MARK: - Custom Method
    
    private func showPopUp(of type: AlertType) {
        
        let alertView = AlertView(type: type)
        let alertViewController = AlertViewController(alertView: alertView)
        self.present(alertViewController, animated: false)
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension MyPageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.section == 0 else { return }
        
        var urlString: String = indexPath.item == 0 ? UrlLiteral.termsOfUse : UrlLiteral.question
        var title: String = indexPath.item == 0 ? I18N.MyPage.terms : I18N.MyPage.askQuestions
        Utils.push(self.navigationController, WebViewController(url: urlString, title: title))
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
