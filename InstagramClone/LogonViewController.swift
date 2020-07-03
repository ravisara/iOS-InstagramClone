//
//  LogonViewController.swift
//  InstagramClone
//
//  Created by StarChanger on 11/06/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import Firebase

class LogonViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func signIn() {
        
        if userEmail.text != "" && userPassword.text != "" {
            Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { (authDataResult, errorFromFirebase) in // strange it did not allow to use the fireBaseError variable name as it is already defined below(possibly)
                if errorFromFirebase != nil {
                    self.showError(errorMessageTitle: "Error from Firebase", errorMessage: errorFromFirebase?.localizedDescription ?? "Unknown Firebase error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            showError(errorMessageTitle: "Missing input", errorMessage: "Username or the password is empty!")
        }
        
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        if userEmail.text != "" && userPassword.text != "" {
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (authDataResult, fireBaseError) in
                if fireBaseError != nil {
                    self.showError(errorMessageTitle: "Error from Firebase", errorMessage: fireBaseError?.localizedDescription ?? "Unknown Firebase error")
                } else { // No error - the operation succeeded.
                    //self.showError(errorMessageTitle: "User creation successful", errorMessage: authDataResult.debugDescription)
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            showError(errorMessageTitle: "Missing input", errorMessage: "Username or the password is empty!")
        }
        
    }
    
    func showError(errorMessageTitle: String, errorMessage: String) {
        
        let alertController = UIAlertController(title: errorMessageTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
