//
//  DescriptionCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class DescriptionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    enum CellColor {
        case basic
        case sub
        case point
    }
    
    private var cellBorderColor: UIColor {
        switch cellColor {
        case .basic: return .gbbGray300!
        case .sub: return .gbbPoint1!
        case .point: return .clear
        }
    }
    
    private var cellBackgroundColor: UIColor {
        switch cellColor {
        case .basic: return .gbbBackground1!
        case .sub: return .gbbBackground1!
        case .point: return .gbbPoint2!
        }
    }
    
    private var cellTextColor: UIColor {
        switch cellColor {
        case .basic: return .gbbGray400!
        case .sub: return .gbbPoint1!
        case .point: return .gbbPoint1!
        }
    }
    
    var cellColor: CellColor = .basic {
        didSet {
            setUI()
        }
    }
    
    // MARK: - UI Property
    
    private let descriptionLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configureTagTitle("")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(6)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = cellBackgroundColor
            $0.makeBorder(width: 0.5, color: cellBorderColor)
            $0.makeCornerRound(radius: 3)
        }
        
        descriptionLabel.do {
            $0.font = .captionM2
            $0.textColor = cellTextColor
            $0.setLineHeight(by: 1.37, with: "")
        }
    }
    
    // MARK: - Custom Method
    
    func configureTagTitle(_ text: String) {
        
        descriptionLabel.text = text
    }
    
}
