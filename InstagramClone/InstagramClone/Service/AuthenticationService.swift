//
//  AuthenticationService.swift
//  InstagramClone
//
//  Created by Apple on 11/2/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation
import FirebaseAuth

struct LoginHelper {
    
    static fileprivate(set) var isLogin = false
    
}

class AuthenticationService {
    
    static let share = AuthenticationService()
    
    private(set) var currentUser: User? {
        didSet {
            if currentUser != nil {
                LoginHelper.isLogin = true
            }
            else {
                LoginHelper.isLogin = false
            }
            NotificationCenter.default.post(name: .DID_CHANGE_CURRENT_USER, object: nil)
        }
    }
    
    func createUser(email: String, password: String, _ completion: ((User?, Error?) -> Void)?) {
        let completion:((User?, Error?) -> Void) = completion ?? {_,_ in}
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let user = result?.user, error == nil {
                completion(user, nil)
                AuthenticationService.share.currentUser = user
            }
            else {
                completion(nil, error)
            }
        }
    }
    
    func login(email: String, password: String, _ completion: ((User?, Error?) -> Void)?) {
        let completion:((User?, Error?) -> Void) = completion ?? {_,_ in}
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let user = result?.user, error == nil {
                completion(user, nil)
                AuthenticationService.share.currentUser = user
            }
            else {
                completion(nil, error)
            }
        }
    }
    
}
