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
    
    var currentStep: Int = 1 {
        willSet {
            navigationBar.configureRightCount(newValue, by: 3)
        }
    }
    var currentFilterType: FilterType = .purpose
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var filterDataSource = FilterDiffableDataSource(filterCollectionView, currentFilterType)
    private let nextButton = CommonButton()
    
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
            $0.bottom.equalTo(nextButton.snp.top).offset(-100)
        }
    }
    
    override func setUI() {
        
        navigationBar.do {
            $0.configureRightCount(1, by: 3)
            $0.configureBackButtonAction(UIAction { [weak self] _ in
                self?.backButtonTapped()
            })
//            $0.hideBackButton(true)
        }
        
        filterCollectionView.do {
            $0.backgroundColor = .clear
        }
        
        filterDataSource.filterType = .purpose
        
        nextButton.do {
            $0.configureButtonTitle(.next)
            $0.configureButtonUI(.gbbGray200!)
            $0.addActionToCommonButton {
                self.nextButtonTapped()
            }
//            $0.isUserInteractionEnabled = false
        }
    }
    
    override func setDelegate() {
        
        filterCollectionView.delegate = self
    }
    
    // MARK: - Action Helper
    
    private func nextButtonTapped() {
        
        filterDataSource.filterType = .breadType
        filterDataSource.configureData()
        currentFilterType = .breadType
        print("-------")
        dump(FilterCellModel.purpose.map { $0.selected })
    }
    
    private func backButtonTapped() {
        filterDataSource.filterType = .purpose
        currentFilterType = .purpose
        print("-------")
        dump(FilterCellModel.purpose.map { $0.selected })
    }
    
    // MARK: - Custom Method
    
//    private func updateCurrentFilter(to type: FilterType) {
//
//        currentFilterType = type
//        filterDataSource.type = type
//        filterCollectionView.allowsMultipleSelection = type.isMultipleSelectionEnabled
//    }
//
//    private func configureNextButton() {
//
//        UIView.animate(withDuration: 0.2) {
//            self.nextButton.do {
//                $0.configureButtonUI(self.isFilterSelected ? .gbbMain2! : .gbbGray200!)
//                $0.isUserInteractionEnabled = self.isFilterSelected
//            }
//        }
//    }
    
//    private func selectedFilterID(of indexPath: IndexPath) -> FilterModel.ID {
//        
//    }
    
}

extension FilterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        FilterCellModel.configureSelection(
            of: currentFilterType,
            at: indexPath.item,
            to: true
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        FilterCellModel.configureSelection(
            of: currentFilterType,
            at: indexPath.item,
            to: false
        )
    }
    
}
