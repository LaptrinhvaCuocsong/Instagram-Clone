//
//  MHLoginViewController.swift
//  InstagramClone
//
//  Created by nguyen manh hung on 10/14/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHLoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    static func createLoginViewController() -> MHLoginViewController {
        let vc = MHLoginViewController(nibName: "MHLoginViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5.0
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func login(_ sender: Any) {
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        let signUpVC = MHSignUpViewController.createSignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
