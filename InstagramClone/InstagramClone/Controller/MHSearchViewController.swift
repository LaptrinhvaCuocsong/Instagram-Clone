//
//  MHSearchViewController.swift
//  InstagramClone
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHSearchViewController: UIViewController {

    static func createSearchViewController() -> MHSearchViewController {
        let vc = MHSearchViewController(nibName: "MHSearchViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
