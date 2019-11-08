//
//  MHLoginViewController.swift
//  InstagramClone
//
//  Created by nguyen manh hung on 10/14/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHLoginViewController: UIViewController {

    @IBOutlet weak var heightPreviewImage: NSLayoutConstraint!
    @IBOutlet weak var marginTopInstagramImage: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var rememberButton: UIButton!
    
    private var isRememberLogin = true {
        didSet {
            if isRememberLogin {
                rememberButton.setImage(UIImage(named: "success_icon"), for: .normal)
            }
            else {
                rememberButton.setImage(UIImage(named: "not_success_icon"), for: .normal)
            }
        }
    }
    
    private var spinnerView: UIActivityIndicatorView?
    
    static func createLoginViewController() -> MHLoginViewController {
        let vc = MHLoginViewController(nibName: "MHLoginViewController", bundle: nil)
        return vc
    }
    
    //MARK: Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
    }
    
    //MARK: Private method
    
    private func handlerLoginSuccess(with email: String, password: String) {
        if isRememberLogin {
            UserdefaultService.share.save(true, key: Constants.REMEBER_USER_KEY)
            KeychainService.share.save(email: email, password: password)
        }
        else {
            UserdefaultService.share.save(false, key: Constants.REMEBER_USER_KEY)
        }
        let tabbarVC = MHRootTabBarController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
    }
    
    private func setUpLayout() {
        rememberButton.layer.borderWidth = 1.0
        rememberButton.layer.borderColor = UIColor.lightGray.cgColor
        loginButton.layer.cornerRadius = 5.0
        navigationController?.navigationBar.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        if DeviceHelper.isIphoneXFamily {
            marginTopInstagramImage.constant = 40.0
        }
        else {
            marginTopInstagramImage.constant = 20.0
        }
        if DeviceHelper.isIphoneSE {
            heightPreviewImage.constant = 120.0
        }
        else {
            heightPreviewImage.constant = 150.0
        }
        loginButton.isEnabled = false
        loginButton.alpha = 0.2
    }
    
    @objc private func validateEmail() {
        if Validator.checkEmpty(emailTextField.text) {
            emailErrorLabel.text = "Email is required"
            emailErrorLabel.isHidden = false
        }
        else if !Validator.isEmailSuccess(emailTextField.text!) {
            emailErrorLabel.text = "Email is invalid"
            emailErrorLabel.isHidden = false
        }
        else {
            emailErrorLabel.isHidden = true
        }
        validateForm()
    }
    
    @objc private func validatePassword() {
        if Validator.checkEmpty(passwordTextField.text) {
            passwordErrorLabel.text = "Password is required"
            passwordErrorLabel.isHidden = false
        }
        else if !Validator.isSuccessPassword(passwordTextField.text!) {
            passwordErrorLabel.text = "Password is invalid"
            passwordErrorLabel.isHidden = false
        }
        else {
            passwordErrorLabel.isHidden = true
        }
        validateForm()
    }
    
    private func validateForm() {
        var isSuccess = true
        // validate email
        if Validator.checkEmpty(emailTextField.text) || !Validator.isEmailSuccess(emailTextField.text!) {
            isSuccess = false
        }
        // validate password
        if Validator.checkEmpty(passwordTextField.text) || !Validator.isSuccessPassword(passwordTextField.text!) {
            isSuccess = false
        }
        if isSuccess {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        }
        else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.2
        }
    }
    
    private func showAlertLoginFail() {
        let alertVC = UIAlertController(title: "Login Fail", message: "Please check your email and password", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

    //MARK: IBAction
    
    @IBAction func login(_ sender: UIButton) {
        loginButton.isEnabled = false
        view.showProgress()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {[weak self] in
            guard let strongSelf = self else { return }
            guard let email = strongSelf.emailTextField.text,
                let password = strongSelf.passwordTextField.text else {
                    strongSelf.view.hideProgress()
                    return
            }
            AuthenticationService.share.login(email: email, password: password) { (user, error) in
                DispatchQueue.main.async {
                    if let _ = user, error == nil {
                        strongSelf.handlerLoginSuccess(with: email, password: password)
                    }
                    else {
                        strongSelf.showAlertLoginFail()
                    }
                    strongSelf.view.hideProgress()
                    strongSelf.loginButton.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func rememberClicked(_ sender: UIButton) {
        isRememberLogin = !isRememberLogin
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        let signUpVC = MHSignUpViewController.createSignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}

extension MHLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
