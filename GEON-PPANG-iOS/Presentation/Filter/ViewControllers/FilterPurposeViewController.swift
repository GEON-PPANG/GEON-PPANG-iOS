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
    private var filterTitleText: String = I18N.Filter.Purpose.title
    private let filterCellTexts: [String] = FilterPurposeType.allCases.map { $0.description }
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let filterTitleLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
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
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterTitleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(55)
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
        }
        
//        flowLayout.do {
//            $0.
//        }
        
        filterCollectionView.do {
            $0.register(cell: FilterCollectionViewCell.self)
        }
    }
    
    override func setDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    
    
}

// MARK: - extension

extension FilterPurposeViewController: UICollectionViewDelegate {}

// MARK: - extension

extension FilterPurposeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterCellTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.filterType = .purpose
        return cell
    }
    
}
