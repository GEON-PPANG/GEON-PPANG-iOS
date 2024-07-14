//
//  GBStackView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 7/10/24.
//

import UIKit

enum GBStackType {
    case big
    case small
    
    var images: [UIImage] {
        switch self {
        case .big: return [.haccpMark28px, .veganMark28px, .gmoMark28px]
        case .small: return [.haccpMark22px, .veganMark22px, .gmoMark22px]
        }
    }
    
    var size: Int {
        switch self {
        case .big: return 28
        case .small: return 24
        }
    }
}

final class GBStackView: UIStackView {
    
    init(type: GBStackType, data: [Bool]) {
        super.init(frame: .zero)
        setUI()
        addCertifiedImageViews(type: type, data: data)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        axis = .horizontal
        spacing = -8
    }
    
    private func addCertifiedImageViews(type: GBStackType, data: [Bool]) {
        data.enumerated()
            .filter { $0.element }
            .map { $0.offset }
            .forEach { index in
                let imageView = UIImageView(image: type.images[index])
                imageView.contentMode = .topLeft
                addArrangedSubview(imageView)
                imageView.snp.makeConstraints {
                    $0.size.equalTo(type.size)
                }
            }
    }
}
