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
    
    var selectedSortBy: SortBakery = .byDefault
    var dataBind: ((SortBakery) -> Void)?
    
    // MARK: - UI Property
    
    private let bottomSheetView = UIView()
    private let sortViewTitle = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var sortBakeryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    // MARK: - Life Cycle
    
    init(sort: SortBakery) {
        
        self.selectedSortBy = sort
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showBottomSheetViewController()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let location = touch.location(in: self.bottomSheetView)
        
        if !self.view.frame.contains(location) {
            dismissBottomSheetViewController()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(convertByHeightRatio(295))
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
            $0.height.equalTo(68)
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
    
    // MARK: - Custom Method
    
    private func dismissBottomSheetViewController() {
        
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = .clear
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    private func showBottomSheetViewController() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            UIView.animate(withDuration: 0.2) {
                self.view.backgroundColor = .black.withAlphaComponent(0.4)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate extension

extension SortBottomSheetViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        case 0:
            selectedSortBy = .byDefault
        case 1:
            selectedSortBy = .byReviews
            
            AnalyticManager.log(event: .list(.clickReviewArray))
        default: dismissBottomSheetViewController()
        }
        dataBind?(selectedSortBy)
        sortBakeryCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.bounds.width, height: 24)
    }
}
