//
//  FilterBreadTypeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class FilterBreadTypeViewController: BaseViewController {
    
    // MARK: - Property
    
    private var maxSteps: Int = 0
    private var filterType: FilterType = .breadType
    
    private let filterTypes: [String] = FilterBreadType.allCases.map { $0.rawValue }
    private let filterDescriptions: [String] = FilterBreadType.allCases.map { $0.description }
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let filterTitleLabel = UILabel()
    private let filterSubtitleLabel = UILabel()
    private let filterCollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterCollectionViewFlowLayout)
    private let nextButton = CommonButton()
    
    // MARK: - Life Cycle
    
    init(maxSteps: Int) {
        super.init(nibName: nil, bundle: nil)
        
        setMaxSteps(to: maxSteps)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNextButtonAction()
    }
    
    // MARK: - Setting
    
    private func setMaxSteps(to steps: Int) {
        self.maxSteps = steps
    }
    
    override func setLayout() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        view.addSubview(filterTitleLabel)
        filterTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(filterSubtitleLabel)
        filterSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(filterTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(55))
            $0.height.equalTo(56)
        }
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterSubtitleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
    }
    
    override func setUI() {
        navigationBar.do {
            $0.addBackButtonAction(popFilterViewController())
            $0.configureRightCount(maxSteps - 1, by: maxSteps)
        }
        
        filterTitleLabel.do {
            $0.text = I18N.Filter.breadTypeTitle
            $0.font = .title1
            $0.textColor = .gbbGray700
            $0.numberOfLines = 1
        }
        
        filterSubtitleLabel.do {
            $0.text = I18N.Filter.breadTypeSubtitle
            $0.font = .subHead
            $0.textColor = .gbbGray400
        }
        
        filterCollectionViewFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = CGFloat().convertByWidthRatio(21)
            $0.minimumInteritemSpacing = CGFloat().convertByHeightRatio(20)
        }
        
        filterCollectionView.do {
            $0.register(cell: FilterCollectionViewCell.self)
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.allowsMultipleSelection = true
        }
        
        nextButton.do {
            $0.getButtonTitle(.next)
            $0.getButtonUI(.gbbGray200!)
            $0.isUserInteractionEnabled = false
        }
    }
    
    override func setDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    private func setNextButtonAction() {
        let action = UIAction { [weak self] _ in
            Utils.push(self?.navigationController, FilterIngredientViewController(maxSteps: 6))
            dump(FilterRequestDTO.sharedData)
        }
        nextButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - Action Helper
    
    private func popFilterViewController() -> UIAction {
        let action = UIAction { [weak self] _ in
            FilterRequestDTO.sharedData.breadType = .init(
                isGlutenFree: false,
                isVegan: false,
                isNutFree: false,
                isSugarFree: false
            )
            self?.navigationController?.popViewController(animated: true)
        }
        return action
    }
    
    // MARK: - Custom Method
    
    private func checkNextButtonStatus() {
        if FilterRequestDTO.sharedData.breadType.isNoneSelected() {
            nextButton.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.nextButton.getButtonUI(.gbbGray200!)
            }
        } else {
            nextButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.nextButton.getButtonUI(.gbbMain2!)
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension FilterBreadTypeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0: FilterRequestDTO.sharedData.breadType.isGlutenFree = true
        case 1: FilterRequestDTO.sharedData.breadType.isVegan = true
        case 2: FilterRequestDTO.sharedData.breadType.isNutFree = true
        case 3: FilterRequestDTO.sharedData.breadType.isSugarFree = true
        default: return
        }
        checkNextButtonStatus()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0: FilterRequestDTO.sharedData.breadType.isGlutenFree = false
        case 1: FilterRequestDTO.sharedData.breadType.isVegan = false
        case 2: FilterRequestDTO.sharedData.breadType.isNutFree = false
        case 3: FilterRequestDTO.sharedData.breadType.isSugarFree = false
        default: return
        }
        checkNextButtonStatus()
    }
    
}

// MARK: - UICollectionViewDataSource extension

extension FilterBreadTypeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.filterType = self.filterType
        cell.typeLabelText = filterTypes[indexPath.item]
        cell.descriptionLabelText = filterDescriptions[indexPath.item]
        return cell
    }
    
}

extension FilterBreadTypeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return filterType.cellSize
    }
    
}
