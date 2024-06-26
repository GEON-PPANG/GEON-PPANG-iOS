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
    
    class func getHeight(_ list: [String]) -> CGFloat {
        var width: CGFloat = 0
        list.forEach {
            width += $0.size(withAttributes: [NSAttributedString.Key.font: UIFont.pretendardMedium(13)]).width + 4 + 12
        }
        width -= 4
        return width < (UIScreen.main.bounds.width - 152) ? 25 : 56
    }
    
    class func showAlert(title: String, description: String, at viewController: UIViewController, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(.init(title: "닫기", style: .default, handler: action))
        viewController.present(alert, animated: true)
    }
    
    static var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return nil }
        return version
    }
    
    class func dateFormatterString(format: String? = nil, date: Date) -> String {
        
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = format ?? "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        let convertStr = formatter.string(from: date)
        return convertStr
    }
    
    class func setDetailSourceType(_ source: AnalyticEventType) {
        AnalyticManager.log(event: .detail(.viewDetailpageAt(source: source.rawValue)))
    }
    
    static var sceneDelegate: SceneDelegate? = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    static func showLoginRequiredSheet(on viewController: UIViewController, type: LoginRequiredViewController.ViewType) {
        let loginRequiredViewController = LoginRequiredViewController(viewType: type)
        loginRequiredViewController.modalPresentationStyle = .pageSheet
        if let sheet = loginRequiredViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        DispatchQueue.main.async {
            viewController.present(loginRequiredViewController, animated: true)
        }
    }
}
