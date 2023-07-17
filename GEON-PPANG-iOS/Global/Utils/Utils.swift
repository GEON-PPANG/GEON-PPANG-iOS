//
//  Utils.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/09.
//

import UIKit

final class Utils {
    
    class func push(_ naviViewController: UINavigationController?, _ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            naviViewController?.isNavigationBarHidden = true
            naviViewController?.pushViewController(viewController, animated: true)
        }
    }
    
    class func modal(_ viewController: UIViewController, _ modalViewController: UIViewController, _ modalStyle: UIModalPresentationStyle) {
        let modalViewController = modalViewController
        modalViewController.modalPresentationStyle = modalStyle
        viewController.present(modalViewController, animated: false)
    }
    
    class func updateCollectionViewConstraint(of collectionView: UICollectionView, byOffset offset: CGFloat = 0) {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height + offset
        guard height != 0 else { return }
        collectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
    class func calculateCollectionViewSize(of collectionView: UICollectionView) -> CGSize {
        let size = collectionView.collectionViewLayout.collectionViewContentSize
        return size
    }
}
