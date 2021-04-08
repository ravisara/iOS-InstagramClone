//
//  PostTableViewCell.swift
//  InstagramClone
//
//  Created by StarChanger on 15/07/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {
    
//    TODO make sure all the UI elements are formatted correctly(after finishing the code as it is not a priority)
        
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var documentID: UILabel!
    
    @IBAction func likeButton() {
        print("like button clicked")
        
        if var count = Int(likeCount.text ?? "")  {
            count = count + 1
            likeCount.text = String(count)
            let firestoreDB = Firestore.firestore()
            let likesDocumentData = ["likes": count] as [String:Any]
            
            firestoreDB.collection("posts").document(documentID.text!).setData(likesDocumentData, merge: true)            
        }
            
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
