//
//  MHPostViewController.swift
//  InstagramClone
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHPostViewController: UIViewController {

    static func createPostViewController() -> MHPostViewController {
        let vc = MHPostViewController(nibName: "MHPostViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
