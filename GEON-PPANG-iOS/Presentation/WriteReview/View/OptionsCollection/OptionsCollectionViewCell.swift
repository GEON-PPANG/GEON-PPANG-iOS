//
//  OptionsCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class OptionsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    enum CellStatus {
        case deselected
        case selected
        case disabled
    }
    
    private var cellBorderColor: UIColor {
        switch status {
        case .deselected: return .gbbGray400!
        case .selected: return .gbbMain3!
        case .disabled: return .gbbGray300!
        }
    }
    
    private var cellTextColor: UIColor {
        switch status {
        case .deselected: return .gbbGray400!
        case .selected: return .gbbMain1!
        case .disabled: return .gbbGray300!
        }
    }
    
    private var status: CellStatus = .deselected
    
    private var cellText: String = ""
    
    override var isSelected: Bool {
        willSet {
            configureCell(to: newValue ? .selected : .deselected )
        }
    }
    
    var isEnabled: Bool = true
    
    // MARK: - UI Property
    
    private let cellLabel = UILabel()
    
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
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(17)
        }
    }
    
    private func setUI() {
        self.do {
            $0.makeCornerRound(radius: 18.5)
            $0.makeBorder(width: 1.5, color: cellBorderColor)
        }
        
        cellLabel.do {
            $0.text = cellText
            $0.font = .captionB1
            $0.textColor = cellTextColor
            $0.textAlignment = .center
        }
    }
    
    // MARK: - Custom Method
    
    func configureCell(to status: CellStatus) {
        self.status = status
        
        self.do {
            $0.makeBorder(width: 1.5, color: cellBorderColor)
        }
        
        cellLabel.do {
            $0.textColor = cellTextColor
        }
    }
    
    func configureCellText(to text: String) {
        self.cellText = text
        
        cellLabel.do {
            $0.text = text
        }
    }
    
}
