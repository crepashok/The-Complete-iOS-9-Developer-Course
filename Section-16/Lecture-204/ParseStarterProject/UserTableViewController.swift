//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var usernames = [String]()
    
    var recipientUsername = ""

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

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.recipientUsername = self.usernames[indexPath.row]
        
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = .PhotoLibrary
        
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let imageToSend = PFObject(className: "UserImage")
        
        imageToSend["photo"] = PFFile(name: "photo.jpe", data: UIImageJPEGRepresentation(image, 0.5)!)
        
        imageToSend["sender"] = PFUser.currentUser()?.username
        
        imageToSend["recipient"] = self.recipientUsername
        
        imageToSend.saveInBackgroundWithBlock { (isSaved, error:NSError?) -> Void in
            
            if error == nil {
            
                print("Image was succesfully uploaded to Parse")
                
            } else {
            
                print("Parse upload image error: \(error?.localizedDescription)")
                
            }
            
        }
    }

}
