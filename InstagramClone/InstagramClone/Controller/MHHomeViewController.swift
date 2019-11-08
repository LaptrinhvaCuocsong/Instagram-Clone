//
//  MHHomeViewController.swift
//  InstagramClone
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHHomeViewController: UIViewController {

    static func createHomeViewController() -> MHHomeViewController {
        let vc = MHHomeViewController(nibName: "MHHomeViewController", bundle: nil)
        return vc
    }
    
    // MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handlerEventDidChangeCurrentUser), name: .DID_CHANGE_CURRENT_USER, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userId = AuthenticationService.share.currentUser?.uid {
            // fetch account
            print("view did load: \(userId)")
        }
    }

    // MARK: - Private method
    
    @objc private func handlerEventDidChangeCurrentUser() {
        print("Did change current user")
        if let userId = AuthenticationService.share.currentUser?.uid {
            print("Noti: \(userId)")
        }
    }
    
}
