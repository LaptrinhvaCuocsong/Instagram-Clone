//
//  Validator.swift
//  InstagramClone
//
//  Created by nguyen manh hung on 10/31/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation

struct Validator {
    
    static func checkEmpty(_ text: String?) -> Bool {
        return text?.isEmpty ?? true
    }
    
    static func isEmailSuccess(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    static func isSuccessPassword(_ password: String) -> Bool {
        let regCheckNumberChar = "[A-Za-z0-9]{8,}"
        let regCheckExistNumber = "\\w*[0-9]+\\w*"
        let regCheckExistUpercase = "\\w*[A-Z]+\\w*"
        let regCheckExistLowercase = "\\w*[a-z]+\\w*"
        let predicateCheckNumberChar = NSPredicate(format: "SELF MATCHES %@", regCheckNumberChar)
        let predicateCheckExistNumber = NSPredicate(format: "SELF MATCHES %@", regCheckExistNumber)
        let predicateCheckExistUpercase = NSPredicate(format: "SELF MATCHES %@", regCheckExistUpercase)
        let predicateCheckExistLowercase = NSPredicate(format: "SELF MATCHES %@", regCheckExistLowercase)
        if predicateCheckNumberChar.evaluate(with: password)
            && predicateCheckExistNumber.evaluate(with: password)
            && predicateCheckExistUpercase.evaluate(with: password)
            && predicateCheckExistLowercase.evaluate(with: password) {
            return true
        }
        return false
    }
    
    static func isSuccessUsername(_ username: String) -> Bool {
        let regCheckNumberChar = "[A-Za-z0-9]{8,}"
        let predicateCheckNumberChar = NSPredicate(format: "SELF MATCHES %@", regCheckNumberChar)
        return predicateCheckNumberChar.evaluate(with: username)
    }
    
}
