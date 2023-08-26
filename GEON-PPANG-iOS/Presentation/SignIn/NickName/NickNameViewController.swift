//
//  NickNameViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class NickNameViewController: BaseViewController {
    
    // MARK: - Property
    
    private var isValid: Bool = false {
        didSet {
            configureButtonUI(isValid)
        }
    }
    
    private var nickname =  UserDefaults.standard.string(forKey: "nickname") ?? ""
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let nicknameTextField = CommonTextView()
    private lazy var checkButton = CommonButton()
    private lazy var nextButton = CommonButton()
    private var backGroundView = BottomSheetAppearView()
    private var bottomSheet = CommonBottomSheet()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboardWhenTappedAround()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(naviView)
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        view.addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(36)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(54))
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    override func setUI() {
        
        naviView.do {
            $0.configureRightCount(3, by: 6)
            $0.configureBackButtonAction(UIAction { _ in
                self.navigationController?.popViewController(animated: true)
            })
        }
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: "건빵에 오신걸 환영해요!\n어떻게 불러드릴까요?",
                     font: .title1!,
                     color: .gbbGray700!)
        }
        
        checkButton.do {
            $0.configureButtonUI(.clear, .gbbGray300)
            $0.configureButtonTitle(.duplicate)
            $0.addActionToCommonButton {
                self.backGroundView.appearBottomSheetView(subView: self.bottomSheet, 281)
            }
        }
        
        nicknameTextField.do {
            $0.cofigureSignInType(.nickname)
            $0.validCheck = { [weak self] valid in
                self?.isValid = valid
            }
            $0.duplicatedCheck = { [weak self] nickname in
                guard let self else { return }
                UserDefaults.standard.setValue(nickname, forKey: "nickname")
            }
        }
        
        nextButton.do {
            $0.isUserInteractionEnabled = false
            $0.configureButtonUI(.gbbGray200!)
            $0.configureButtonTitle(.next)
        }
        
        bottomSheet.do {
            $0.getEmojiType(.smile)
            $0.getBottonSheetTitle(I18N.Bottomsheet.diableNickname)
            $0.dismissBottomSheet = {
                self.backGroundView.dissmissFromSuperview()
                self.nextButton.do {
                    $0.isUserInteractionEnabled = true
                    $0.configureButtonUI(.gbbMain2!)
                    $0.tappedCommonButton = {
                        Utils.push(self.navigationController, FilterViewController(isInitial: true))
                    }
                }
            }
        }
    }
    
    func configureButtonUI(_ isValid: Bool) {
        
        self.checkButton.do {
            $0.isEnabled = isValid
            $0.configureButtonUI(.clear, isValid ? .gbbMain2! : .gbbGray300!)
        }
        
        if !isValid {
            nextButton.do {
                $0.isUserInteractionEnabled = false
                $0.configureButtonUI(.gbbGray200!)
            }
        }
    }
    
    func dismissKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(endEditingView))
        tap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tap)
    }
}
