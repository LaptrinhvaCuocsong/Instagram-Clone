//
//  Validator.swift
//  InstagramClone
//
//  Created by nguyen manh hung on 10/31/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation

struct Validator {
    
    static func isEmailSuccess(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    static func isPasswordSuccess(_ password: String) -> Bool {
        let regex = ""
    }
    
}
