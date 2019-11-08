//
//  UIView+Extension.swift
//  InstagramClone
//
//  Created by Apple on 11/4/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    
    func showProgress() {
        subviews.forEach { (view) in
            if view is MBProgressHUD {
                view.removeFromSuperview()
            }
        }
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.isUserInteractionEnabled = false
        hud.backgroundView.color = UIColor(white: 0.6, alpha: 0.5)
        hud.show(animated: true)
    }
    
    func hideProgress() {
        MBProgressHUD.hide(for: self, animated: false)
    }
    
}
