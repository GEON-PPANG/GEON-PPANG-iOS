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
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
    override func setUI() {
        
        collectionView.do {
//            $0.register(cell: )
              $0.register(cell: BakeryListCollectionViewCell.self)
//            $0.backgroundColor = .red
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        switch indexPath.section {
//        case 0:
//            guard let collection
//        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BakeryListCollectionViewCell.identifier, for: indexPath) as? BakeryListCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension BakeryDetailViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        switch indexPath.section {
//        case 0:
//            return CGSize(width: UIScreen.main.bounds.width - 40, height: 300)
//        default:
//            return CGSize(width: UIScreen.main.bounds.width - 40, height: 95)
//        }
//    }
}
