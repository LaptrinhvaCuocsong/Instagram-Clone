//
//  MHSignUpViewController.swift
//  InstagramClone
//
//  Created by nguyen manh hung on 10/14/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class MHSignUpViewController: UIViewController {

    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var imagePickerVC: UIImagePickerController!
    
    static func createSignUpViewController() -> MHSignUpViewController {
        let vc = MHSignUpViewController(nibName: "MHSignUpViewController", bundle: nil)
        return vc
    }

    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 5.0
    }
    
    //MARK:  IBAction
    
    @IBAction func selectImage(_ sender: Any) {
        let alertVC = UIAlertController(title: "Choose image from", message: nil, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Camera", style: .default, handler: {[weak self] (_) in
            guard let strongSelf = self else { return }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                strongSelf.imagePickerVC = UIImagePickerController()
                strongSelf.imagePickerVC.sourceType = .camera
                strongSelf.imagePickerVC.delegate = self
                strongSelf.imagePickerVC.allowsEditing = true
                strongSelf.present(strongSelf.imagePickerVC, animated: true, completion: nil)
            }
        }))
        alertVC.addAction(UIAlertAction(title: "Photo library", style: .default, handler: {[weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.imagePickerVC = UIImagePickerController()
            strongSelf.imagePickerVC.delegate = strongSelf
            strongSelf.imagePickerVC.sourceType = .photoLibrary
            strongSelf.imagePickerVC.allowsEditing = true
            strongSelf.present(strongSelf.imagePickerVC, animated: true, completion: nil)
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MHSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectImageButton.setImage(image, for: .normal)
            selectImageButton.layer.cornerRadius = selectImageButton.frame.height / 2
            selectImageButton.clipsToBounds = true
            selectImageButton.contentMode = .scaleAspectFill
            selectImageButton.layer.borderWidth = 2.0
            selectImageButton.layer.borderColor = UIColor.black.cgColor
            selectImageButton.layer.shadowColor = UIColor.lightGray.cgColor
            selectImageButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}
