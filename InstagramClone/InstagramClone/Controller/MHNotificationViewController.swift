//
//  MHNotificationViewController.swift
//  InstagramClone
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHNotificationViewController: UIViewController {

    static func createNotificationViewController() -> MHNotificationViewController {
        let vc = MHNotificationViewController(nibName: "MHNotificationViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
