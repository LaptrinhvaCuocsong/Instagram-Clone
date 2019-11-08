//
//  MHSignUpViewController.swift
//  InstagramClone
//
//  Created by nguyen manh hung on 10/14/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHSignUpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var avartarErrorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var fullNameErrorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    private var imagePickerVC: UIImagePickerController!
    private var spinnerView: UIActivityIndicatorView?
    
    fileprivate var didSelectImage = false {
        didSet {
            if didSelectImage {
                avartarErrorLabel.isHidden = true
            }
            else {
                avartarErrorLabel.text = "Avatar is required"
                avartarErrorLabel.isHidden = false
            }
            view.layoutIfNeeded()
            validateForm()
        }
    }
    
    static func createSignUpViewController() -> MHSignUpViewController {
        let vc = MHSignUpViewController(nibName: "MHSignUpViewController", bundle: nil)
        return vc
    }

    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.2
        emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(validateFullname), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(validateUsername), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        setUpLayout()
        imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
    }
    
    //MARK:  IBAction
    
    @IBAction func selectImage(_ sender: Any) {
        let alertVC = UIAlertController(title: "Choose image from", message: nil, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Camera", style: .default, handler: {[weak self] (_) in
            guard let strongSelf = self else { return }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                strongSelf.imagePickerVC.sourceType = .camera
                strongSelf.present(strongSelf.imagePickerVC, animated: true, completion: nil)
            }
        }))
        alertVC.addAction(UIAlertAction(title: "Photo library", style: .default, handler: {[weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.imagePickerVC.sourceType = .photoLibrary
            strongSelf.present(strongSelf.imagePickerVC, animated: true, completion: nil)
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        signUpButton.isEnabled = false
        view.showProgress()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {[weak self] in
            guard let strongSelf = self else { return }
            if !strongSelf.didSelectImage {
                strongSelf.avartarErrorLabel.text = "Avatar is required"
                strongSelf.avartarErrorLabel.isHidden = false
                strongSelf.view.layoutIfNeeded()
                strongSelf.signUpButton.alpha = 0.2
                strongSelf.view.hideProgress()
            }
            else {
                guard let email = strongSelf.emailTextField.text,
                    let fullName = strongSelf.fullNameTextField.text,
                    let username = strongSelf.usernameTextField.text,
                    let password = strongSelf.passwordTextField.text else {
                        strongSelf.signUpButton.alpha = 0.2
                        strongSelf.showAlertSignUpFail("Please check your infomation")
                        strongSelf.view.hideProgress()
                        return
                }
                strongSelf.createUser(email: email, password: password, fullName: fullName, username: username, success: {
                    DispatchQueue.main.async {
                        strongSelf.signUpButton.isEnabled = true
                        strongSelf.view.hideProgress()
                    }
                }) {
                    DispatchQueue.main.async {
                        strongSelf.signUpButton.isEnabled = true
                        strongSelf.view.hideProgress()
                        strongSelf.showAlertSignUpFail("Please check your information")
                    }
                }
            }
        }
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private method

    private func createUser(email: String, password: String, fullName: String, username: String, success: (() -> Void)?, failure: (() -> Void)?) {
        let success:(() -> Void) = success ?? {}
        let failure:(() -> Void) = failure ?? {}
        AuthenticationService.share.createUser(email: email, password: password) {[weak self] (user, error) in
            if let user = user, error == nil {
                let userId = user.uid
                self?.uploadImage(userId: userId, email: email, password: password, fullName: fullName, username: username, success: success, failure: failure)
            }
            else {
                failure()
            }
        }
    }
    
    private func uploadImage(userId: String, email: String, password: String, fullName: String, username: String, success: (() -> Void)?, failure: (() -> Void)?) {
        let success:(() -> Void) = success ?? {}
        let failure:(() -> Void) = failure ?? {}
        guard let image = selectImageButton.image(for: .normal), let imageData = image.pngData() else {
            failure()
            return
        }
        StorageService.share.upload(path: "account/\(userId)", data: imageData) {[weak self] (url, error) in
            if let imageUrl = url?.absoluteString, error == nil {
                let account = Account(accountId: userId, email: email, fullName: fullName, username: username, imageUrl: imageUrl)
                self?.saveAccount(account: account, success: success, failure: failure)
            }
            else {
                failure()
            }
        }
    }
    
    private func saveAccount(account: Account, success: (() -> Void)?, failure: (() -> Void)?) {
        let success:(() -> Void) = success ?? {}
        let failure:(() -> Void) = failure ?? {}
        AccountService.share.saveAccount(account) { (error) in
            if error == nil {
                // signUp success
                success()
            }
            else {
                failure()
            }
        }
    }
    
    private func showAlertSignUpFail(_ message: String?) {
        let alertVC = UIAlertController(title: "SignUp fail", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
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
        view.layoutIfNeeded()
        validateForm()
    }
        
    @objc private func validateFullname() {
        if Validator.checkEmpty(fullNameTextField.text) {
            fullNameErrorLabel.text = "Fullname is required"
            fullNameErrorLabel.isHidden = false
        }
        else {
            fullNameErrorLabel.isHidden = true
        }
        view.layoutIfNeeded()
        validateForm()
    }
    
    @objc private func validateUsername() {
        if Validator.checkEmpty(usernameTextField.text) {
            userNameErrorLabel.text = "Username is required"
            userNameErrorLabel.isHidden = false
        }
        else if !Validator.isSuccessUsername(usernameTextField.text!) {
            userNameErrorLabel.text = "Username is invalid"
            userNameErrorLabel.isHidden = false
        }
        else {
            userNameErrorLabel.isHidden = true
        }
        view.layoutIfNeeded()
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
        view.layoutIfNeeded()
        validateForm()
    }
    
    private func validateForm() {
        var isSuccess = true
        // validate email
        if Validator.checkEmpty(emailTextField.text) || !Validator.isEmailSuccess(emailTextField.text!) {
            isSuccess = false
        }
        // validate fullName
        if Validator.checkEmpty(fullNameTextField.text) {
            isSuccess = false
        }
        // validate username
        if Validator.checkEmpty(usernameTextField.text) || !Validator.isSuccessUsername(usernameTextField.text!) {
            isSuccess = false
        }
        // validate password
        if Validator.checkEmpty(passwordTextField.text) || !Validator.isSuccessPassword(passwordTextField.text!) {
            isSuccess = false
        }
        // validate avatar image
        if !avartarErrorLabel.isHidden {
            isSuccess = false
        }
        if !isSuccess {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.2
        }
        else {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
        }
    }
    
    private func setUpLayout() {
        signUpButton.layer.cornerRadius = 5.0
        avartarErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        fullNameErrorLabel.isHidden = true
        userNameErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    private func setUpSelectImageButton(with image: UIImage) {
        selectImageButton.setImage(image, for: .normal)
        selectImageButton.clipsToBounds = true
        selectImageButton.layer.cornerRadius = selectImageButton.frame.height / 2
        selectImageButton.contentMode = .scaleAspectFill
        selectImageButton.layer.borderWidth = 1.0
        selectImageButton.layer.borderColor = UIColor.black.cgColor
    }
    
}

extension MHSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            setUpSelectImageButton(with: image)
            picker.dismiss(animated: true, completion: nil)
            didSelectImage = true
        }
        else {
            didSelectImage = false
        }
    }
    
}

extension MHSignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
