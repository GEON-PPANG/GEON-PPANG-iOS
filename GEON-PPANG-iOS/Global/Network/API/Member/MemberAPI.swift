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
    typealias DeleteUserResponse = GeneralResponse<DeleteUserResponseDTO>
    
    static let shared = MemberAPI()
    
    private init() {}
    
    public private(set) var setNicknameResponse: SetNicknameResponse?
    public private(set) var fetchNicknameResponse: FetchNicknameResponse?
    public private(set) var deleteUserResponse: DeleteUserResponse?
    
    var memberProvider = MoyaProvider<MemberService>(session: Session(interceptor: AuthInterceptor.shared), plugins: [AuthPlugin()])
    
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
    
    func logout(completion: @escaping (Int?) -> Void) {
        
        memberProvider.request(.logout) { result in
            switch result {
            case .success(let response):
                completion(response.statusCode)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func deleteUser(completion: @escaping (DeleteUserResponse?) -> Void) {
        
        let type = KeychainService.readKeychain(of: .socialType)
        memberProvider.request(type == "APPLE" ? .appleWithdraw : .withdraw) { result in
            switch result {
            case .success(let response):
                do {
                    self.deleteUserResponse = try response.map(DeleteUserResponse.self)
                    guard let deleteUserResponse = self.deleteUserResponse else { return }
                    completion(deleteUserResponse)
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
