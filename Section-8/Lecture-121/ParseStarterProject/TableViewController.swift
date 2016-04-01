//
//  TableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {
    
    var usernames = [""]
    
    var userids = [""]
    
    var isFollowing = ["":false]
    
    var refresher:UIRefreshControl!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Update Users table")
        
        refresher.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refresher)
        
        self.refresh()

    }
    
    
    func refresh() {
        let query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) in
            
            if let users = objects {
                
                self.usernames.removeAll(keepCapacity: true)
                
                self.userids.removeAll(keepCapacity: true)
                
                self.isFollowing.removeAll(keepCapacity: true)
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        if user.objectId! != PFUser.currentUser()?.objectId {
                            
                            self.usernames.append(user.username!)
                            
                            self.userids.append(user.objectId!)
                            
                            let query = PFQuery(className: "followers")
                            
                            if let currentUser = PFUser.currentUser()?.objectId {
                                
                                query.whereKey("follower", equalTo: currentUser)
                                
                                query.whereKey("following", equalTo: user.objectId!)
                                
                                query.findObjectsInBackgroundWithBlock({ (objects, error) in
                                    
                                    if let objects = objects {
                                        
                                        if objects.count > 0 {
                                            
                                            self.isFollowing[user.objectId!] = true
                                            
                                        } else {
                                            
                                            self.isFollowing[user.objectId!] = false
                                            
                                        }
                                        
                                    }
                                    
                                    if self.isFollowing.count == self.usernames.count {
                                        
                                        self.tableView.reloadData()
                                        
                                        self.refresher.endRefreshing()
                                        
                                    }
                                    
                                })
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        })
        
    }
    

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let followedObjectID = userids[indexPath.row]

        if isFollowing[followedObjectID] == true {
        
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
        }
        
        cell.textLabel?.text = usernames[indexPath.row]
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        let followedObjectID = userids[indexPath.row]
        
        if isFollowing[followedObjectID] == false {
            
            isFollowing[followedObjectID] = true
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            let following = PFObject(className: "followers")
            
            following["following"] = userids[indexPath.row]
            
            following["follower"] = PFUser.currentUser()?.objectId
            
            following.saveInBackground()
            
        } else {
        
            isFollowing[followedObjectID] = false
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            let query = PFQuery(className: "followers")
            
            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
            
            query.whereKey("following", equalTo: userids[indexPath.row])
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                
                if let objects = objects {
                    
                    for object in objects {
                    
                        object.deleteInBackground()
                        
                    }
                    
                }
                
            })
            
        }
        
    }

}
