//
//  FeedTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    var messages = [String]()
    
    var usernames = [String]()
    
    var imageFiles = [PFFile]()
    
    var users = [String: String]()
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) in
            
            if let users = objects {
                
                self.usernames.removeAll(keepCapacity: true)
                
                self.usernames.removeAll(keepCapacity: true)
                
                self.imageFiles.removeAll(keepCapacity: true)
                
                self.users.removeAll(keepCapacity: true)
                
                for object in users {
                    
                    if let user = object as? PFUser {
                    
                        self.users[user.objectId!] = user.username
                        
                    }
                    
                }
                
            }
            
        })
        
        let getFollowedUsersQuery = PFQuery(className: "followers")
        
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
        
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
            
                for object in objects {
                
                    let followedUser = object["following"] as! String
                    
                    let query = PFQuery(className: "Post")
                    
                    query.whereKey("userId", equalTo: followedUser)
                    
                    query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                        
                        if let objects = objects {
                        
                            for object in objects {
                                
                                self.messages.append(object["message"]! as! String)
                                
                                self.imageFiles.append(object["imageFile"]! as! PFFile)
                                
                                self.usernames.append(self.users[object["userId"] as! String]!)
                                
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    })
                    
                }
                
            }
            
        }
        
    }

    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usernames.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let feedCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! cell

        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            
            if error == nil {
                
                if let downloadedImage = UIImage(data: data!) {
                    
                    feedCell.postedImage.image = downloadedImage
                    
                }
            
            } else {
                
                print("Some errors with doqnloading image. Reason: \(error?.localizedDescription)")
            
            }
            
            
        }
        
        feedCell.username.text = usernames[indexPath.row]
        
        feedCell.message.text = messages[indexPath.row]
        
        return feedCell
    }
    

}
