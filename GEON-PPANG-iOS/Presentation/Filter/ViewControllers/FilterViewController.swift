//
//  PurposeFilterViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/17.
//

import UIKit

import SnapKit
import Then

final class FilterViewController: BaseViewController {
    
    // MARK: - Property
    
    var isInitial: Bool
    var currentFilterType: FilterType = .purpose
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var filterDataSource = FilterDiffableDataSource(filterCollectionView, currentFilterType)
    private let nextButton = CommonButton()
    private let skipButton = UIButton()
    
    // MARK: - Life Cycle
    
    init(isInitial: Bool) {
        self.isInitial = isInitial
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnalyticManager.log(event: .onboarding(.startFilterOnboarding))
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
            $0.hideBackButton(isInitial ? true : false)
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
            $0.isHidden = !isInitial
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
            newFilterType = .breadType
        case .breadType:
            newFilterType = .ingredient
            nextButton.configureButtonTitle(.apply)
        case .ingredient:
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
        
        AnalyticManager.log(event: .onboarding(.clickSkip))
        
        Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
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
        case .purpose: navigationBar.hideBackButton(isInitial ? true : false)
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
        
        guard isInitial else { return }
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
        FilterAPI.shared.changeFilter(to: request) { response in
            if self.isInitial {
                Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        resetFilterSelections()
    }
    
}

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
