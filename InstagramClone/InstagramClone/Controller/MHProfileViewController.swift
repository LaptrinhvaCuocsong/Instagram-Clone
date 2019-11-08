//
//  MHProfileViewController.swift
//  InstagramClone
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHProfileViewController: UIViewController {

    static func createProfileViewController() -> MHProfileViewController {
        let vc = MHProfileViewController(nibName: "MHProfileViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
