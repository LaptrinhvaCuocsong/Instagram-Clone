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
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private method
    
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
        }
    }
    
}
