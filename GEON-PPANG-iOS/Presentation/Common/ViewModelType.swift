//
//  ViewModelType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/19/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
