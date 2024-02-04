//
//  PurposeFilterViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/17.
//

import UIKit

import SnapKit
import Then

enum From {
    case onboarding
    case home
    case list
    case mypage
}

final class FilterViewController: BaseViewController {
    
    // MARK: - Property
    
    var from: From
    var currentFilterType: FilterType = .purpose
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var filterDataSource = FilterDiffableDataSource(filterCollectionView, currentFilterType)
    private let nextButton = CommonButton()
    private let skipButton = UIButton()
    
    // MARK: - Life Cycle
    
    init(from: From) {
        self.from = from
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(55))
            $0.height.equalTo(56)
        }
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(nextButton.snp.top).offset(-50)
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
            $0.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(27)
            $0.width.equalTo(85)
        }
    }
    
    override func setUI() {
        
        navigationBar.do {
            $0.configureRightCount(1, by: 3)
            $0.configureBottomLine()
            $0.configureBackButtonAction(UIAction { [weak self] _ in
                self?.backButtonTapped()
            })
            $0.hideBackButton(from == .onboarding ? true : false)
        }
        
        filterCollectionView.do {
            $0.backgroundColor = .clear
        }
        
        filterDataSource.filterType = .purpose
        
        nextButton.do {
            $0.configureButtonTitle(.next)
            $0.configureButtonUI(.gbbGray200!)
            $0.tappedCommonButton = {
                self.nextButtonTapped()
            }
            $0.isUserInteractionEnabled = false
        }
        
        skipButton.do {
            $0.setTitle(I18N.Filter.skip, for: .normal)
            $0.setTitleColor(.gbbGray500, for: .normal)
            $0.titleLabel?.font = .bodyM2
            $0.setImage(.rightArrowIcon.resize(to: .init(width: 16, height: 16)),
                        for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.isHidden = !(self.from == .onboarding)
            $0.addAction(UIAction { [weak self] _ in
                self?.skipButtonTapped()
            }, for: .touchUpInside)
        }
    }
    
    override func setDelegate() {
        
        filterCollectionView.delegate = self
    }
    
    // MARK: - Action Helper
    
    private func nextButtonTapped() {
        
        var newFilterType: FilterType = currentFilterType
        switch currentFilterType {
        case .purpose:
            sendFilterAmplitudeLog()
            newFilterType = .breadType
        case .breadType:
            sendFilterAmplitudeLog()
            newFilterType = .ingredient
            nextButton.configureButtonTitle(.apply)
        case .ingredient:
            sendFilterAmplitudeLog()
            sendRequest()
            return
        }
        
        filterDataSource.filterType = newFilterType
        currentFilterType = newFilterType
        
        configureOnFilterChange()
    }
    
    private func backButtonTapped() {
        
        var newFilterType: FilterType = currentFilterType
        switch currentFilterType {
        case .purpose:
            self.sendBackAmplitudeLog()
            self.navigationController?.popViewController(animated: true)
            return
        case .breadType:
            newFilterType = .purpose
        case .ingredient:
            newFilterType = .breadType
            nextButton.configureButtonTitle(.next)
        }
        
        FilterCellModel.deselectContents(of: currentFilterType)
        FilterCellModel.deselectContents(of: newFilterType)
        filterDataSource.filterType = newFilterType
        currentFilterType = newFilterType
        
        configureOnFilterChange()
    }
    
    private func skipButtonTapped() {
        
        Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
        AnalyticManager.log(event: .onboarding(.clickSkip))
    }
    
    // MARK: - Custom Method
    
    private func configureNextButton() {
        
        let isAnySelected = FilterCellModel.isAnySelected(of: currentFilterType)
        nextButton.isUserInteractionEnabled = isAnySelected ? true : false
        UIView.animate(withDuration: 0.2) {
            self.nextButton.configureButtonUI(isAnySelected ? .gbbMain2! : .gbbGray200!)
        }
    }
    
    private func configureBackButton() {
        
        switch currentFilterType {
        case .purpose: navigationBar.hideBackButton(self.from == .onboarding ? true : false)
        case .breadType, .ingredient: navigationBar.hideBackButton(false)
        }
    }
    
    private func configureStepCount() {
        
        switch currentFilterType {
        case .purpose: navigationBar.configureRightCount(1, by: 3)
        case .breadType: navigationBar.configureRightCount(2, by: 3)
        case .ingredient: navigationBar.configureRightCount(3, by: 3)
        }
    }
    
    private func configureSkipButton() {
        
        guard self.from == .onboarding else { return }
        switch self.currentFilterType {
        case .purpose:
            UIView.animate(withDuration: 0.2) {
                self.skipButton.layer.opacity = 1
            } completion: { _ in
                self.skipButton.isHidden = false
            }
        case .breadType, .ingredient:
            UIView.animate(withDuration: 0.2) {
                self.skipButton.layer.opacity = 0
            } completion: { _ in
                self.skipButton.isHidden = true
            }
        }
        
    }
    
    private func configureOnFilterChange() {
        
        configureNextButton()
        configureBackButton()
        configureStepCount()
        configureSkipButton()
    }
    
    private func resetFilterSelections() {
        
        FilterCellModel.deselectContents(of: .purpose)
        FilterCellModel.deselectContents(of: .breadType)
        FilterCellModel.deselectContents(of: .ingredient)
    }
    
    private func sendRequest() {
        
        var request = FilterRequestDTO()
        request.setPurpose(from: FilterCellModel.purpose.map { $0.selected })
        request.setBreadType(from: FilterCellModel.breadType.map { $0.selected })
        request.setNutrientType(from: FilterCellModel.ingredient.map { $0.selected })
        
        MemberAPI.shared.postFilter(request: request) { _ in
            self.sendFilterCompleteAmplitudeLog(from: request)
            if self.from == .onboarding {
                Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        resetFilterSelections()
    }
    
}

// MARK: - amplitude functions

extension FilterViewController {
    private func sendFilterAmplitudeLog() {
        guard self.from == .onboarding else { return }
        switch self.currentFilterType {
        case .purpose: AnalyticManager.log(event: .onboarding(.clickMainpurpose(mainPurpose: "")))
        case .breadType: AnalyticManager.log(event: .onboarding(.clickBreadtype(breadType: [""])))
        case .ingredient: AnalyticManager.log(event: .onboarding(.clickIngredientstype(ingredientsType: [""])))
        }
    }
    
    private func sendFilterCompleteAmplitudeLog(from request: FilterRequestDTO) {
        switch self.from {
        case .onboarding:
            AnalyticManager.log(event: .onboarding(.completeFilterOnboarding(
                mainPurpose: request.mainPurpose,
                breadType: request.breadType.convertToStringArray(),
                ingredientsType: request.nutrientType.convertToStringArray()
            )))
        case .home:
            AnalyticManager.log(event: .home(.completeFilterHome(
                mainPurpose: request.mainPurpose,
                breadType: request.breadType.convertToStringArray(),
                ingredientsType: request.nutrientType.convertToStringArray()
            )))
        case .list:
            AnalyticManager.log(event: .list(.completeFilterList(
                mainPurpose: request.mainPurpose,
                breadType: request.breadType.convertToStringArray(),
                ingredientsType: request.nutrientType.convertToStringArray()
            )))
        case .mypage:
            AnalyticManager.log(event: .myPage(.completeFilterMypage(
                mainPurpose: request.mainPurpose,
                breadType: request.breadType.convertToStringArray(),
                ingredientsType: request.nutrientType.convertToStringArray()
            )))
        }
    }
    
    private func sendBackAmplitudeLog() {
        switch self.from {
        case .home: AnalyticManager.log(event: .home(.clickFilterBackHome))
        case .list: AnalyticManager.log(event: .list(.clickFilterbackList))
        case .mypage: AnalyticManager.log(event: .myPage(.clickFilterBackMypage))
        default: return
        }
    }
}

// MARK: - UICollectionViewDelegate

extension FilterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        FilterCellModel.configureSelection(
            of: currentFilterType,
            at: indexPath.item,
            to: true
        )
        
        if currentFilterType == .purpose {
            nextButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.nextButton.configureButtonUI(.gbbMain2!)
            }
        } else {
            configureNextButton()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        FilterCellModel.configureSelection(of: currentFilterType,
                                           at: indexPath.item,
                                           to: false)
        
        if currentFilterType == .purpose {
            return
        } else {
            configureNextButton()
        }
    }
}
