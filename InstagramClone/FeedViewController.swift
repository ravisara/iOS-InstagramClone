//
//  FirstViewController.swift
//  InstagramClone
//
//  Created by StarChanger on 18/05/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var postComment = [String]()
    var postedBy = [String]()
    var likes = [Int]()
    var date = [String]()
    var imageURL = [String]()
    var documentIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromDatabase()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postedBy.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! PostTableViewCell
        cell.email.text = postedBy[indexPath.row]
        cell.myImageView.image = UIImage(named: "select.png")
        cell.comments.text = postComment[indexPath.row]
        cell.likeCount.text = String(likes[indexPath.row])
        cell.myImageView.sd_setImage(with: URL(string: imageURL[indexPath.row]))
        cell.documentID.text = documentIDs[indexPath.row]
        return cell
        
    }
    
    func getDataFromDatabase() {
        
        let myFirestore = Firestore.firestore()
        myFirestore.collection("posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true || snapshot != nil {
                    
                    self.postComment.removeAll()
                    self.postedBy.removeAll()
                    self.likes.removeAll()
                    self.date.removeAll()
                    self.imageURL.removeAll()
                    self.documentIDs.removeAll()
                    
                    for document in snapshot!.documents {
                        
                        print(document.documentID)
                        self.documentIDs.append(document.documentID)
                        
                        if let email = document.get("postedBy") as? String {
                            self.postedBy.append(email)
                        }
                        
                        if let comment = document.get("postComment") as? String {
                            self.postComment.append(comment)
                        }
                        
                        if let dateOfPost = document.get("date") as? String {
                            self.date.append(dateOfPost)
                        }
                        
                        if let likesCount = document.get("likes") as? Int {
                            self.likes.append(likesCount)
                        }
                        
                        if let urlText = document.get("imageURL") as? String {
                            self.imageURL.append(urlText)
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
              
        
    }
    
    
}

