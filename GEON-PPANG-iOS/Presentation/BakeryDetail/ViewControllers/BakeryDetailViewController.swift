//
//  BakeryDetailViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class BakeryDetailViewController: BaseViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setUI() {
        
        collectionView.do {
            $0.registerCells(cells: [TitleCollectionViewCell.self,
                                     InfoCollectionViewCell.self,
                                     MenuCollectionViewCell.self,
                                     ReviewCategoryCollectionViewCell.self,
                                     WrittenReviewsCollectionViewCell.self])
            $0.register(header: BakeryDetailCollectionViewHeader.self)
            $0.register(footer: BakeryDetailCollectionViewFooter.self)
            
            $0.backgroundColor = .gbbGray200
        }
    }
    
    override func setLayout() {
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setDelegate() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension BakeryDetailViewController: UICollectionViewDelegate { }

extension BakeryDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 2:
            return 3 // 예시
        case 4:
            return 4 // 예시
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: TitleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            return cell
        case 1:
            let cell: InfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            return cell
        case 2:
            let cell: MenuCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            return cell
        case 3:
            let cell: ReviewCategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            return cell
        case 4:
            let cell: WrittenReviewsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 1:
            let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.getType(.info)
            
            return header
        case 2:
            if kind == UICollectionView.elementKindSectionHeader {
                let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
                header.getType(.menu)
                
                return header
            } else {
                let footer: BakeryDetailCollectionViewFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, indexPath: indexPath)
                
                return footer
            }
        case 3:
            let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.getType(.reviewCategory)
            
            return header
        case 4:
            let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.getType(.writtenReviews)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension BakeryDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: getDeviceWidth(), height: 443)
        case 1:
            return CGSize(width: getDeviceWidth(), height: 235)
        case 2:
            return CGSize(width: getDeviceWidth() - 48, height: 20)
        case 3:
            return CGSize(width: getDeviceWidth() - 48, height: 134)
        case 4:
            return CGSize(width: getDeviceWidth() - 48, height: 173)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 1:
            return CGSize(width: collectionView.frame.width, height: 72)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 64)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 70)
        case 4:
            return CGSize(width: collectionView.frame.width, height: 77)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
//        case 2:
//        case 3:
//        case 4:
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
