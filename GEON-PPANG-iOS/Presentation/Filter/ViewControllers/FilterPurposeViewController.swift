//
//  FilterPurposeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class FilterPurposeViewController: BaseViewController {
    
    // MARK: - Property
    
    private var maxSteps: Int = 0
    private var userName: String = "Id"
    private var selectedFilter: String!
    
    private var filterType: FilterType = .purpose
    private var filterTitleText: String = I18N.Filter.purposeTitle
    private let filterTypes: [String] = FilterPurposeType.allCases.map { $0.rawValue }
    private let filterDescriptions: [String] = FilterPurposeType.allCases.map { $0.description }
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let filterTitleLabel = UILabel()
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
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(55)
            $0.height.equalTo(56)
        }
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterTitleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(nextButton.snp.top).offset(-40)
        }
    }
    
    override func setUI() {
        navigationBar.do {
            $0.addBackButtonAction(popViewControllerAction())
            $0.configureRightCount(maxSteps - 2, by: maxSteps)
        }
        
        filterTitleLabel.do {
            $0.text = filterTitleText.insertString(userName, at: 5)
            $0.font = .title1
            $0.textColor = .gbbGray700
            $0.numberOfLines = 2
        }
        
        filterCollectionViewFlowLayout.do {
            $0.scrollDirection = .vertical
        }
        
        filterCollectionView.do {
            $0.register(cell: FilterCollectionViewCell.self)
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
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
            // TODO: to next filter selection
            print(self?.selectedFilter)
        }
        nextButton.addAction(action, for: .touchUpInside)
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension FilterPurposeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilter = filterTypes[indexPath.item]
        UIView.animate(withDuration: 0.2) {
            self.nextButton.do {
                $0.getButtonUI(.gbbMain2!)
                $0.isUserInteractionEnabled = true
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource extension

extension FilterPurposeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.filterType = .purpose
        cell.typeLabelText = filterTypes[indexPath.item]
        cell.descriptionLabelText = filterDescriptions[indexPath.item]
        return cell
    }
}

extension FilterPurposeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return filterType.cellSize
    }
}