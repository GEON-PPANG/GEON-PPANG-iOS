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
            $0.register(cell: MyPageProfileCell.self)
            $0.register(cell: MyPageBasicCell.self)
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
        
        myPageDataSource.leaveTapped = {
            self.showPopUp(of: .leave)
        }
    }
    
    // MARK: - Custom Method
    
    private func showPopUp(of type: AlertType) {
        
        let alertView = AlertView(type: type)
        let alertViewController = AlertViewController(alertView: alertView)
        alertViewController.configureAlertAction { [weak self] in
            self?.deleteMember()
        }
        self.present(alertViewController, animated: false)
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension MyPageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 1:
            Utils.push(self.navigationController, WebViewController(
                url: indexPath.item == 0 ? UrlLiteral.termsOfUse : UrlLiteral.question,
                title: indexPath.item == 0 ? I18N.MyPage.terms : I18N.MyPage.askQuestions
            ))
        case 3:
            self.showPopUp(of: .logout)
        default:
            break
        }
    }
}

// MARK: - API

extension MyPageViewController {
    
    func requestMemberData() {
        
        MyPageAPI.shared.getMemberData { response in
            guard let response = response,
                  let data = response.data
            else { return }
            
            self.memberData = data
            self.myPageDataSource.loadData()
        }
    }
    
    func deleteMember() {
        
        AuthAPI.shared.deleteUser { response in
            switch response?.code {
            case 200:
                KeychainService.deleteAllAuthKeychains()
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
            default:
                if let child = self.children.first {
                    child.dismiss(animated: true)
                }
                Utils.showAlert(title: "회원탈퇴 실패", description: "실패", at: self) { _ in
                    Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
                }
            }
        }
    }
}
