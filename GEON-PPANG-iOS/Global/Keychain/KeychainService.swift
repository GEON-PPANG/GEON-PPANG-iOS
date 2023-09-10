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
            kSecAttrLabel as String: key.label,
            kSecValueData as String: value.data(using: .utf8) as Any
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Set: Keychain created successfully 🔒")
        case errSecDuplicateItem:
            print("❌ Set: Keychain item already exists ❌")
            print("❌ Set: Keychain update ❌")
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
            kSecAttrLabel as String: key.label,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Read: Keychain read successfully 🔒")
        case errSecItemNotFound:
            print("❌ Read: Keychain item not found ❌")
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
            print("❌ Read: Keychain decoding failed ❌")
            return ""
        }
        
        return token
    }
    
    // MARK: - update keychain
    
    static func updateKeychain(of key: KeychainKey, to value: String) {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]
        let attributes: [String: Any] = [
            kSecAttrService as String: serviceName,
            kSecAttrLabel as String: key.label,
            kSecValueData as String: value.data(using: .utf8) as Any
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Update: Keychain updated successfully  🔒")
        case errSecItemNotFound:
            print("❌ Update: Keychain item not found ❌")
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
            kSecAttrLabel as String: key.label
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Delete: Keychain deleted successfully 🔒")
            return true
        case errSecItemNotFound:
            print("❌ Delete: Keychain item not found ❌")
        default:
            print("❌ Delete: Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
        }
        return false
        #endif
    }
}
