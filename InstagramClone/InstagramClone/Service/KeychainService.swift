//
//  KeychainService.swift
//  InstagramClone
//
//  Created by Apple on 11/6/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation
import KeychainSwift

class KeychainService {
    
    static let share = KeychainService()
    
    private let keychain: KeychainSwift
    private let emailKey = "email"
    private let passwordKey = "password"
    
    private init() {
        keychain = KeychainSwift(keyPrefix: "instagram_clone")
        keychain.synchronizable = true
    }
    
    func save(email: String?, password: String?) {
        if let email = email, let password = password {
            keychain.set(email, forKey: emailKey)
            keychain.set(password, forKey: passwordKey)
        }
        else {
            keychain.delete(emailKey)
            keychain.delete(passwordKey)
        }
    }
    
    func get() -> (email: String, password: String)? {
        if let email = keychain.get(emailKey), let password = keychain.get(passwordKey) {
            return (email: email, password: password)
        }
        return nil
    }
    
}
