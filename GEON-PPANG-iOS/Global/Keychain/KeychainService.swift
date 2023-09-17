//
//  KeychainService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/08.
//

import Foundation

class KeychainService {
    
    static let serviceName = "GEON-PPANG"
    
    // MARK: - create keychain
    
    static func setKeychain(of key: KeychainKey, with value: String) {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.account,
            kSecValueData as String: value.data(using: .utf8) as Any
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Set: Keychain of \(key) created successfully 🔒")
        case errSecDuplicateItem:
            print("❌ Set: Keychain of \(key) item already exists ❌")
            print("❌ Set: Keychain of \(key) update ❌")
            updateKeychain(of: key, to: value)
        default:
            print("❌ Set: Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
        }
        #endif
    }
    
    // MARK: - read keychain
    
    static func readKeychain(of key: KeychainKey) -> String {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.account,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Read: Keychain of \(key) read successfully 🔒")
        case errSecItemNotFound:
            print("❌ Read: Keychain of \(key) item not found ❌")
            return ""
        default:
            print("❌ Read: Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
            return ""
        }
        #endif
        
        guard let decodedItem = item as? [String: Any],
              let tokenData = decodedItem[kSecValueData as String] as? Data,
              let token = String(data: tokenData, encoding: .utf8)
        else {
            print("❌ Read: Keychain of \(key) decoding failed ❌")
            return ""
        }
        
        return token
    }
    
    // MARK: - update keychain
    
    static func updateKeychain(of key: KeychainKey, to value: String) {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.account
        ]
        let attributes: [String: Any] = [
            kSecValueData as String: value.data(using: .utf8) as Any
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Update: Keychain of \(key) updated successfully  🔒")
        case errSecItemNotFound:
            print("❌ Update: Keychain of \(key) item not found ❌")
        default:
            print("❌ Update: Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
        }
        #endif
    }
    
    // MARK: - delete keychain
    
    @discardableResult
    static func deleteKeychain(of key: KeychainKey) -> Bool {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Delete: Keychain of \(key) deleted successfully 🔒")
            return true
        case errSecItemNotFound:
            print("❌ Delete: Keychain of \(key) item not found ❌")
        default:
            print("❌ Delete: Unknown of \(key) error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
        }
        return false
        #endif
    }
}
