//
//  MyPageModel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/28.
//

import Foundation

struct MyPageModel: Identifiable {
    
    let id: Int
    let title: String
}

extension MyPageModel {
    
    static let general: [MyPageModel] = [
        .init(id: 1, title: "이용약관"),
        .init(id: 2, title: "문의하기")
    ]
    
    static let version: [MyPageModel] = [
        .init(id: 3, title: "버전 정보")
    ]
}
