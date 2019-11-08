//
//  StorageService.swift
//  InstagramClone
//
//  Created by Apple on 11/2/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    static let share = StorageService()
    
    func upload(path: String, data: Data, _ completion: ((URL?, Error?) -> Void)?) {
        let completion:((URL?, Error?) -> Void) = completion ?? {_,_ in}
        let storageReference = Storage.storage().reference().child(path)
        storageReference.putData(data, metadata: nil) { (storageMetadata, error) in
            if storageMetadata != nil && error == nil {
                storageReference.downloadURL { (url, error) in
                    if let url = url, error == nil {
                        completion(url, nil)
                    }
                    else {
                        completion(nil, error)
                    }
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    
}
