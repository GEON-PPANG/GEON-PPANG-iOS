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
    private var userName =  UserDefaults.standard.string(forKey: "nickname") ?? ""
    
    private var filterType: FilterType = .purpose
    
    private let filterTypes: [String] = FilterPurposeType.allCases.map { $0.rawValue }
    private let filterDescriptions: [String] = FilterPurposeType.allCases.map { $0.description }
    private let filterDatas: [String] = FilterPurposeType.allCases.map { $0.data }
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let filterTitleLabel = UILabel()
    private let filterCollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterCollectionViewFlowLayout)
    private let nextButton = CommonButton()
    
    // MARK: - Life Cycle
    
    init(maxSteps: Int, username: String) {
        super.init(nibName: nil, bundle: nil)
        
        setMaxSteps(to: maxSteps)
        setUsername(to: username)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNextButtonAction()
        print("3 - ", UserDefaults.standard.string(forKey: "nickname") ?? "")
    }
    
    // MARK: - Setting
    
    private func setMaxSteps(to steps: Int) {
        self.maxSteps = steps
    }
    
    private func setUsername(to name: String) {
        self.userName = name
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
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(55))
            $0.height.equalTo(56)
        }
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterTitleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
    }
    
    override func setUI() {
        navigationBar.do {
            $0.addBackButtonAction(popFilterViewController())
            $0.configureRightCount(maxSteps - 2, by: maxSteps)
        }
        
        filterTitleLabel.do {
            $0.text = I18N.Filter.purposeTitle.insertString(userName, at: 5)
            $0.font = .title1
            $0.textColor = .gbbGray700
            $0.numberOfLines = 2
        }
        
        filterCollectionViewFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 20
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
            Utils.push(self?.navigationController, FilterBreadTypeViewController(maxSteps: self?.maxSteps ?? 0))
            dump(FilterRequestDTO.sharedData)
        }
        nextButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - Action Helper
    
    private func popFilterViewController() -> UIAction {
        let action = UIAction { [weak self] _ in
            print(UserDefaults.standard.string(forKey: "nickname") ?? "")
            FilterRequestDTO.sharedData.mainPurpose = ""
            self?.navigationController?.popViewController(animated: true)
        }
        return action
    }
    
    // MARK: - Custom Method
    
    private func enableNextButton() {
        UIView.animate(withDuration: 0.2) {
            self.nextButton.do {
                $0.getButtonUI(.gbbMain2!)
                $0.isUserInteractionEnabled = true
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension FilterPurposeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        FilterRequestDTO.sharedData.mainPurpose = filterDatas[indexPath.item]
        enableNextButton()
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
