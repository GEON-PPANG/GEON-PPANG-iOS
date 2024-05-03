//
//  Endpoint.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 4/3/24.
//

import Foundation

/// `Domain 레이어를 모르면서` Data 레이어에서 신경쓰지 않아도 될 요소들 구현
///
/// e.g.
/// - APIClient: API 통신하는 실질적인 부분, request 등과 같은 것들 구현하면 좋을듯
///     - 외부 DB랑 내부 DB랑 따로 구분해야 할수도
/// - APIConfiguration도 여기서 정의해두는게 좋을듯, header 등
/// - Endpoint: 실질적인 `요청을 보내는` 형태
/// - 그 외에도 현재 `Global/Network/Base`에 있는 몇가지 요소들 등 여기에 구현
