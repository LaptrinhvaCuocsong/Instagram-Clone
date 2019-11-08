//
//  MHRootTabBarController.swift
//  InstagramClone
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHRootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
        tabBar.tintColor = .black
        autoLogin()
    }
    
    // MARK: - Private method
    
    private func autoLogin() {
        if let authData = KeychainService.share.get(), !LoginHelper.isLogin {
            AuthenticationService.share.login(email: authData.email, password: authData.password) { (_, error) in
                if error != nil {
                    let alertVC = UIAlertController(title: "Auth fail", message: nil, preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func setUpViewControllers() {
        // SetUp home
        let homeVC = MHHomeViewController.createHomeViewController()
        let homeNC = setUpNavigationController(rootViewController: homeVC, selectedImage: UIImage(named: "home_selected"), unselectedImage: UIImage(named: "home_unselected"), tabTitle: nil)
        // SetUp search
        let searchVC = MHSearchViewController.createSearchViewController()
        let searchNC = setUpNavigationController(rootViewController: searchVC, selectedImage: UIImage(named: "search_selected"), unselectedImage: UIImage(named: "search_unselected"), tabTitle: nil)
        // SetUp post
        let postVC = MHPostViewController.createPostViewController()
        let postNC = setUpNavigationController(rootViewController: postVC, selectedImage: UIImage(named: "plus_unselected"), unselectedImage: UIImage(named: "plus_unselected"), tabTitle: nil)
        // SetUp notification
        let notificationVC = MHNotificationViewController.createNotificationViewController()
        let notificationNC = setUpNavigationController(rootViewController: notificationVC, selectedImage: UIImage(named: "like_selected"), unselectedImage: UIImage(named: "like_unselected"), tabTitle: nil)
        // SetUp profile
        let profileVC = MHProfileViewController.createProfileViewController()
        let profileNC = setUpNavigationController(rootViewController: profileVC, selectedImage: UIImage(named: "profile_selected"), unselectedImage: UIImage(named: "profile_unselected"), tabTitle: nil)
        viewControllers = [homeNC, searchNC, postNC, notificationNC, profileNC]
    }
    
    private func setUpNavigationController(rootViewController: UIViewController, selectedImage: UIImage?, unselectedImage: UIImage?, tabTitle: String?) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.image = unselectedImage
        navVC.tabBarItem.selectedImage = selectedImage
        navVC.navigationBar.tintColor = .black
        navVC.tabBarItem.title = tabTitle
        return navVC
    }

}
