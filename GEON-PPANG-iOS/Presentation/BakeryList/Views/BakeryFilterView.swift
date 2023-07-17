//
//  BakeryFilterView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class BakeryFilterView: UIView {
    
    // MARK: - Property
    
    enum Section: Hashable {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, BakeryFilterItems>
    private var dataSource: DataSource?
    private var filterlist: [BakeryFilterItems] = BakeryFilterItems.item
    
    // MARK: - UI Property
    
    private lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
//    private lazy var filterButton = UIButton(configuration: .plain())
    private let filterButtonTitleLabel = UILabel()
    private let filterButtonImageView = UIImageView(image: .swapIcon)
    private lazy var filterButton = UIButton()
    
    private let topView = UIView()
    private let lineView = UIView()
    private let bottomView = UIView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        
        setRegistration()
        setDataSource()
        setReloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        filterCollectionView.do {
            $0.delegate = self
            $0.showsHorizontalScrollIndicator = false
        }
        
        filterButtonTitleLabel.do {
            $0.text = "기본순"
            $0.font = .captionB1
            $0.textColor = .gbbGray700
        }
        
        filterButton.do {
            $0.configuration?.background.strokeWidth = 1
            $0.configuration?.background.strokeColor = .gbbGray200
            $0.configuration?.baseForegroundColor = .black
            $0.configuration?.image = .swapIcon
            $0.configuration?.attributedTitle = AttributedString(I18N.BakeryList.defaultFilter,
                                                                 attributes: AttributeContainer([.font: UIFont.pretendardBold(13)]))
            $0.configuration?.cornerStyle = .capsule
            $0.configuration?.imagePadding = 5
            $0.configuration?.contentInsets = .zero
            $0.addAction(UIAction { _ in
                print("tapped")
            }, for: .touchUpInside)
        }
        
//        filterButton.do {
//            $0.configuration?.background.strokeWidth = 1
//            $0.configuration?.background.strokeColor = .gbbGray200
//            $0.configuration?.baseForegroundColor = .black
//            $0.configuration?.image = .swapIcon
//            $0.configuration?.attributedTitle = AttributedString("기본순", attributes: AttributeContainer([.font: UIFont.pretendardBold(13)]))
//            $0.configuration?.cornerStyle = .capsule
//            $0.configuration?.imagePadding = 5
//            $0.configuration?.contentInsets = .zero
//            $0.addAction(UIAction { _ in
//                print("tapped")
//            }, for: .touchUpInside)
//        }
        
        lineView.do {
            $0.backgroundColor = .gbbGray200
        }
        [topView, bottomView].forEach {
            $0.backgroundColor = .gbbGray200
        }
    }
    
    private func setLayout() {
        addSubviews(topView, filterButton, lineView, filterCollectionView, bottomView)
        filterButton.addSubviews(filterButtonImageView, filterButtonTitleLabel)
        
        topView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        filterButtonImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(9)
        }
        
        filterButtonTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(filterButtonImageView)
            $0.leading.equalTo(filterButtonImageView.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        filterButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.leading.equalTo(filterButton.snp.trailing).offset(12)
            $0.directionalVerticalEdges.equalToSuperview().inset(15)
        }
        
        filterCollectionView.snp.makeConstraints {
            $0.leading.equalTo(lineView.snp.trailing)
            $0.centerY.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        bottomView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 13, bottom: 0, right: 13)
        return layout
    }
    
    private func setRegistration() {
        filterCollectionView.register(cell: BakeryFilterCollectionViewCell.self)
    }
    
    private func setDataSource() {
        dataSource = DataSource(collectionView: filterCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell: BakeryFilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.bind(item: item, index: indexPath.item)
            return cell
        })
    }
    
    private func setReloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BakeryFilterItems>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.main])
        snapshot.appendItems(filterlist)
    }
    
    // MARK: - Custom Method
    
    func applyAction(_ action: @escaping () -> Void) {
        let action = UIAction { _ in
            action()
        }
        filterButton.addAction(action, for: .touchUpInside)
    }
    
    func configureFilterButtonText(to text: String) {
        filterButtonTitleLabel.do {
            $0.text = text
        }
    }
}

extension BakeryFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.filterlist[indexPath.item].status == .off {
            self.filterlist[indexPath.item].status = .on
        } else {
            self.filterlist[indexPath.item].status = .off
        }
        self.filterlist[indexPath.item] = self.filterlist[indexPath.item].isSelected()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, BakeryFilterItems>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filterlist)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension BakeryFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat
        let cell: BakeryFilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.filterTitle.text = filterlist[indexPath.row].filter.title
        cell.getSize()
        cellWidth = cell.filterTitle.frame.width + 48
        
        return CGSize(width: cellWidth, height: 36)
    }
}
