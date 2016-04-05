//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    var usernames = [String]()

    override func viewDidLoad() {

        super.viewDidLoad()
        
        let query = PFUser.query()!
        
        query.whereKey("username", notEqualTo: PFUser.currentUser()!.username!)
        
        query.findObjectsInBackgroundWithBlock({ (usersList, error:NSError?) -> Void in
            
            if error == nil {
                
                for user in usersList as! [PFUser] {
                    
                    self.usernames.append(user.username!)
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
        
            PFUser.logOut()
            
            
        }
    }

}
