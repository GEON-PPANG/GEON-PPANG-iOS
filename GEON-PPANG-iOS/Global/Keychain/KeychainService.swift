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
    
    static func createKeychain(of key: KeychainKey, with value: String) {
        
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
            print("🔒   Keychain created successfully   🔒")
        case errSecDuplicateItem:
            print("❌ Keychain item already exists ❌")
        default:
            print("❌ Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
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
            print("🔒    Keychain read successfully     🔒")
        case errSecItemNotFound:
            print("❌ Keychain item not found ❌")
            return ""
        default:
            print("❌ Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
            return ""
        }
        #endif
        
        guard let decodedItem = item as? [String: Any],
              let tokenData = decodedItem[kSecValueData as String] as? Data,
              let token = String(data: tokenData, encoding: .utf8)
        else {
            print("❌ Keychain decoding failed ❌")
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
            print("🔒  Keychain updated successfully  🔒")
        case errSecItemNotFound:
            print("❌ Keychain item not found ❌")
        default:
            print("❌ Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
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
            print("🔒  Keychain deleted successfully  🔒")
            return true
        case errSecItemNotFound:
            print("❌ Keychain item not found ❌")
        default:
            print("❌ Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
        }
        return false
        #endif
    }
    
    // MARK: - existence keychain
    
    static func keychainExists(of key: KeychainKey) -> Bool {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrLabel as String: key.label
        ]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        #if DEBUG
        switch status {
        case errSecSuccess:
            print("🔒 Following keychain already exists 🔒")
            print("🔒      Update to new keychain       🔒")
            return true
        case errSecItemNotFound:
            print("🔒 Following keychain doesn't exist 🔒")
            print("🔒       Create new keychain        🔒")
            return false
        default:
            print("❌ Unknown error: \(SecCopyErrorMessageString(status, nil).debugDescription) ❌")
            return false
        }
        #endif
    }
}
