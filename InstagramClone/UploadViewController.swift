//
//  SecondViewController.swift
//  InstagramClone
//
//  Created by StarChanger on 18/05/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //@IBOutlet weak var uploadPhotoUIImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.isUserInteractionEnabled = true
        let tapGuestureRecognizerForView = UITapGestureRecognizer(target: self, action: #selector(generalViewTapped))
        view.addGestureRecognizer(tapGuestureRecognizerForView)
        
        imageView.isUserInteractionEnabled = true
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerTapped))
        imageView.addGestureRecognizer(tapGuestureRecognizer)
        
    }
    
    @objc
    func generalViewTapped() {
        view.endEditing(true)
    }
    
    @objc
    func gestureRecognizerTapped() {
        
        let myImagePickerController = UIImagePickerController()
        myImagePickerController.delegate = self
        myImagePickerController.sourceType = .photoLibrary
        myImagePickerController.allowsEditing = true
        
        self.present(myImagePickerController, animated: true, completion: nil)
       
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

