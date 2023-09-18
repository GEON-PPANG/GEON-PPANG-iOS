//
//  KakaoService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/18.
//

import Foundation

import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

final class KakaoService {
    
    static func getKakaoAuthCode(_ completion: @escaping (String?) -> Void) {
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { response, error in
                guard error == nil
                else {
                    print("login with kakaoTalk failed with error: \(String(describing: error))")
                    return
                }
                
                guard let token = response?.accessToken
                else { return }
                
                completion(token)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { response, error in
                guard error == nil
                else {
                    print("login with kakaoTalk failed with error: \(String(describing: error))")
                    return
                }
                
                guard let token = response?.accessToken
                else { return }
                
                completion(token)
            }
        }
    }
    
    static func logout() {
        
        UserApi.shared.logout { err in
            guard err == nil else {
                dump(err)
                return
            }
            print("logout success")
        }
    }
    
    static func unlink() {
        
        UserApi.shared.unlink { err in
            guard err == nil else {
                dump(err)
                return
            }
            print("unlink success")
        }
    }
}
