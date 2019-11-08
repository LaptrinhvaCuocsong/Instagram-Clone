//
//  AccountService.swift
//  InstagramClone
//
//  Created by Apple on 11/3/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation
import FirebaseFirestore

class AccountService {
    
    fileprivate let accountCollection = "accounts"
    
    static let share = AccountService()
    
    func saveAccount(_ account: Account, _ completion: ((Error?) -> Void)?) {
        let completion:((Error?) -> Void) = completion ?? {_ in}
        let db = Firestore.firestore()
        let documentData: [String: Any] = [
            "account_id": account.accountId,
            "email": account.email,
            "full_name": account.fullName,
            "username": account.username,
            "imageUrl": account.imageUrl
        ]
        db.collection(accountCollection).document(account.accountId).setData(documentData) { (error) in
            if let error = error {
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
}
