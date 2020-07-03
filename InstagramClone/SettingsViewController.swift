//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by StarChanger on 11/06/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

 
    @IBAction func logout() {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLogonViewController", sender: nil)
        } catch {
            print(error)
        }
        
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
