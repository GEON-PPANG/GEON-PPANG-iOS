//
//  UICollectionViewCell+.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/17.
//

import UIKit

extension UICollectionViewCell {
    
    func fittingSize(availableHeight: CGFloat) -> CGSize {
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return self.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// Constraint 설정 시 노치 유무로 기기를 대응하는 상황에서 사용
    func constraintByNotch(_ hasNotch: CGFloat, _ noNotch: CGFloat) -> CGFloat {
        return UIScreen.main.hasNotch ? hasNotch : noNotch
    }
    
    func heightConsideringNotch(_ height: CGFloat) -> CGFloat {
        return UIScreen.main.hasNotch ? height : height - 24
    }
    
    func heightConsideringBottomSafeArea(_ height: CGFloat) -> CGFloat {
        return UIScreen.main.hasNotch ? height : height - 34
    }
    
    /// 아이폰 13 미니(width 375)를 기준으로 레이아웃을 잡고, 기기의 width 사이즈를 곱해 대응 값을 구할 때 사용
    func convertByWidthRatio(_ convert: CGFloat) -> CGFloat {
        return (convert / 375) * getDeviceWidth()
    }
    
    /// 아이폰 13 미니(height 812)를 기준으로 레이아웃을 잡고, 기기의 height 사이즈를 곱해 대응 값을 구할 때 사용
    func convertByHeightRatio(_ convert: CGFloat) -> CGFloat {
        return (convert / 812) * getDeviceHeight()
    }
}
