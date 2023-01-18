//
//  Auth.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

let keychainKey = "keychainKey"

enum Auth {
    static var userID: UUID?
    static var token: String? {
        get {
            Keychain.load(key: keychainKey)
        }
        set {
            if let newToken = newValue {
                Keychain.save(key: keychainKey, data: newToken)
            } else {
                Keychain.delete(key: keychainKey)
            }
        }
    }
}
