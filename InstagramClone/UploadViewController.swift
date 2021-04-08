//
//  SecondViewController.swift
//  InstagramClone
//
//  Created by StarChanger on 18/05/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
       
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.isUserInteractionEnabled = true
        let tapGuestureRecognizerForView = UITapGestureRecognizer(target: self, action: #selector(generalViewTapped))
        view.addGestureRecognizer(tapGuestureRecognizerForView)
        
        myImageView.isUserInteractionEnabled = true
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerTapped))
        myImageView.addGestureRecognizer(tapGuestureRecognizer)
        
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
        
        myImageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func showAlert(titleToShow: String, messageToShow: String) {
        
        let alertController = UIAlertController(title: titleToShow, message: messageToShow, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okButton)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func uploadButton() {
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
           
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
    
        // Create a child reference
        // folderRef now points to "media"
        let folderRef = storageRef.child("media")
              
        if let imageData = myImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let nameOfImage = UUID.init().uuidString + ".jpg"
            let imageRef = folderRef.child(nameOfImage)
            imageRef.putData(imageData, metadata: nil) { (metaData, error) in
                if error != nil {
                    self.showAlert(titleToShow: "Error", messageToShow: error?.localizedDescription ?? "Unknown error")
                } else {
                    imageRef.downloadURL { (downloadURL, downloadURLError) in
                        if downloadURLError == nil {
                            
                            // Store the post details in the DB. Note the image uploading happens to a separate storage place. Now we are going to store the download URL in a different post
                            let fireStoreDatabase = Firestore.firestore()
                            
                            let firebasePost = ["imageURL": downloadURL?.absoluteString, "postedBy" : Auth.auth().currentUser?.email, "postComment": self.commentTextField.text, "date": FieldValue.serverTimestamp(), "likes": 0] as [String : Any]
                            
                            let documentRef: DocumentReference?
                            documentRef = fireStoreDatabase.collection("posts").addDocument(data: firebasePost, completion: { (error) in
                                if error != nil {
                                    self.showAlert(titleToShow: "Error creating post", messageToShow: error?.localizedDescription ?? "unknown error")
                                } else {
                                    self.showAlert(titleToShow: "Success", messageToShow: "Post was successfully created")
                                    self.commentTextField.text = ""
                                    self.myImageView.image = UIImage(named: "select.png")
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
        }
        
    }
    
}

