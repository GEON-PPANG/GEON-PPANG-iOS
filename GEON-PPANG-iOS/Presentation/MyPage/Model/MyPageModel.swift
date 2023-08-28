//
//  MyPageModel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/28.
//

import Foundation

struct MyPageModel {
    
    let title: String
}

extension MyPageModel {
    
    static let general: [MyPageModel] = [
        .init(title: "이용약관"),
        .init(title: "문의하기")
    ]
    
    static let version: [MyPageModel] = [
        .init(title: "버전 정보")
    ]
}
