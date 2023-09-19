//
//  MemberAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/18.
//

import Foundation

import Moya

final class MemberAPI {
    
    typealias SetNicknameResponse = GeneralResponse<SetNicknameResponseDTO>
    typealias FetchNicknameResponse = GeneralResponse<FetchNicknameResponseDTO>
    
    static let shared = MemberAPI()
    
    private init() {}
    
    public private(set) var setNicknameResponse: SetNicknameResponse?
    public private(set) var fetchNicknameResponse: FetchNicknameResponse?
    
    var memberProvider = MoyaProvider<MemberService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggingPlugin()])
    
    func postSetNickname(to data: NicknameRequestDTO, completion: @escaping (SetNicknameResponse?) -> Void) {
        
        memberProvider.request(.setNickname(request: data)) { result in
            switch result {
            case .success(let response):
                do {
                    self.setNicknameResponse = try response.map(SetNicknameResponse.self)
                    guard let response = self.setNicknameResponse else { return }
                    completion(response)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getNickname(completion: @escaping (FetchNicknameResponse?) -> Void) {
        
        memberProvider.request(.fetchNickname) { result in
            switch result {
            case .success(let response):
                do {
                    self.fetchNicknameResponse = try response.map(FetchNicknameResponse.self)
                    guard let response = self.fetchNicknameResponse else { return }
                    completion(response)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
