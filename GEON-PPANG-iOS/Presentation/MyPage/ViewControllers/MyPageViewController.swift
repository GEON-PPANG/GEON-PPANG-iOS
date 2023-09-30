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
            $0.configureCenterTitle(to: I18N.MyPage.title, with: .title1!)
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
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func setDelegate() {

        myPageCollectionView.delegate = self
    }
    
    private func setCollectionViewActions() {
        
        myPageDataSource.filterButtonTapped = {
            AnalyticManager.log(event: .myPage(.startFilterMypage))
            Utils.push(self.navigationController, FilterViewController(from: .mypage))
        }
        myPageDataSource.myReviewsTapped = {
            AnalyticManager.log(event: .myPage(.clickMyreview))
            Utils.push(self.navigationController, MyReviewsViewController())
        }
        myPageDataSource.savedBakeryTapped = {
            AnalyticManager.log(event: .myPage(.clickMystore))
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
            switch type {
            case .logout:
                self?.logout()
            case .leave:
                self?.deleteUser()
            }
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
    
    func logout() {
        
        MemberAPI.shared.logout { code in
            switch code {
            case 200:
                KeychainService.deleteKeychain(of: .access)
                KeychainService.deleteKeychain(of: .refresh)
                if KeychainService.readKeychain(of: .socialType) == "KAKAO" {
                    KakaoService.logout()
                }
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
                AnalyticManager.log(event: .general(.logoutApp))
            default:
                print("🔴failed")
            }
        }
    }
    
    func deleteUser() {
        
        MemberAPI.shared.deleteUser { response in
            switch response?.code {
            case 200:
                if KeychainService.readKeychain(of: .socialType) == "KAKAO" {
                    KakaoService.unlink()
                }
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
                KeychainService.deleteAllAuthKeychains()
                AnalyticManager.log(event: .general(.withdrawApp))
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
