//
//  UserdefaultService.swift
//  InstagramClone
//
//  Created by Apple on 11/7/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation

class UserdefaultService {
    
    static let share = UserdefaultService()
    
    private let userdefault = UserDefaults()
    
    func save(_ data: Any?, key: String) {
        userdefault.set(data, forKey: key)
    }
    
    func get(with key: String) -> Any? {
        return userdefault.object(forKey: key)
    }
    
}
