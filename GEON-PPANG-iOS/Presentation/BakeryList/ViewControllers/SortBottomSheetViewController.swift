//
//  SortBottomSheetViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class SortBottomSheetViewController: BaseViewController {
    
    // MARK: - Property
    
    private let bottomSheetHeight: CGFloat = 215
    var selectedSortBy: SortBakery = .byDefault
    var dataBind: ((SortBakery) -> Void)?
    
    // MARK: - UI Property
    
    private let dimmedView = UIView()
    private let bottomSheetView = UIView()
    
    private let sortViewTitle = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var sortBakeryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    // MARK: - Life Cycle
    
    init(sort: SortBakery) {
        self.selectedSortBy = sort
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDimmedViewTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
        print("test ---", selectedSortBy)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateCollectionViewConstraint(of: sortBakeryCollectionView)
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        bottomSheetView.addSubview(sortViewTitle)
        sortViewTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        bottomSheetView.addSubview(sortBakeryCollectionView)
        sortBakeryCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortViewTitle.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }
    
    override func setUI() {
        view.do {
            $0.backgroundColor = .clear
        }
        
        bottomSheetView.do {
            $0.backgroundColor = .gbbWhite
            $0.layer.cornerRadius = 12
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.clipsToBounds = true
        }
        
        sortViewTitle.do {
            $0.text = I18N.SortBottomSheet.sortBy
            $0.font = .bodyM1
            $0.textColor = .gbbGray400
        }
        
        flowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 20
        }
        
        sortBakeryCollectionView.do {
            $0.register(cell: SortBakeryCollectionViewCell.self)
        }
    }
    
    override func setDelegate() {
        sortBakeryCollectionView.delegate = self
        sortBakeryCollectionView.dataSource = self
    }
    
    private func setDimmedViewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissingComponentTapped(_:)))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.isUserInteractionEnabled = true
    }
    
    private func showBottomSheet() {
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.do {
                $0.backgroundColor = .black.withAlphaComponent(0.4)
            }
            self.bottomSheetView.snp.updateConstraints {
                $0.height.equalTo(self.bottomSheetHeight)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Action Helper
    
    @objc
    private func dismissingComponentTapped(_ tapRecognizer: UITapGestureRecognizer) {
        dismissBottomSheetViewController()
    }
    
    // MARK: - Custom Method
    
    private func dismissBottomSheetViewController() {
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.do {
                $0.backgroundColor = .black.withAlphaComponent(0.0)
            }
            self.bottomSheetView.snp.makeConstraints {
                $0.height.equalTo(0)
            }
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    // TODO: Utils 로 빠진 함수 사용
    func updateCollectionViewConstraint(of collectionView: UICollectionView) {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        guard height != 0 else { return }
        collectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension SortBottomSheetViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0: selectedSortBy = .byDefault
        case 1: selectedSortBy = .byReviews
        default: dismissBottomSheetViewController()
        }
        dataBind?(selectedSortBy)
//        print("selectedSortBy - sheet", selectedSortBy)
        dismissBottomSheetViewController()
    }
    
}

// MARK: - UICollectionViewDataSource extension

extension SortBottomSheetViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SortBakery.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SortBakeryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = SortBakery.allCases.map { $0.description }
        cell.configureLabel(to: data[indexPath.item])
//        switch indexPath.item {
//        case 0:
//            if selectedSortBy == .byDefault
//        }
        if selectedSortBy == .byDefault && indexPath.item == 0 {
            cell.configureSelected()
        } else if selectedSortBy == .byReviews && indexPath.item == 1 {
            cell.configureSelected()
        }
        return cell
    }
    
}

// MARK: - UICollectionDelegateFlowLayout extension

extension SortBottomSheetViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 24)
    }
    
}
