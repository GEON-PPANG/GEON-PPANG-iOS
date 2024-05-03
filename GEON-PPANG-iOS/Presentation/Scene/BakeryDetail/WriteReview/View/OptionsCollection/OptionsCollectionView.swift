//
//  OptionsCollectionView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class OptionsCollectionView: UICollectionView {
    
    // MARK: - Property
    
    private enum OptionsType {
        case like
        case recommendation
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.do {
            $0.register(cell: OptionsCollectionViewCell.self)
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
        }
    }
    
    // MARK: - Custom Method
    
    private func resetCellsAreSelected() {
        
        self.indexPathsForSelectedItems?.forEach({ indexPath in
            self.deselectItem(at: indexPath, animated: false)
        })
    }
    
    func toggleIsEnabled(to isLikeSelected: Bool) {
        
        self.isUserInteractionEnabled = isLikeSelected
        self.resetCellsAreSelected()
        self.visibleCells.forEach { cell in
            guard let optionCell = cell as? OptionsCollectionViewCell
            else { return }
            optionCell.configureCell(to: isLikeSelected ? .deselected : .disabled)
        }
    }
    
}
