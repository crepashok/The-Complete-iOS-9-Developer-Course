//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UserTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var usernames = [String]()
    
    var recipientUsername = ""
    
    
    func checkForMessage() {
        
        if let activeUser = PFUser.currentUser()?.username {
            
            let query = PFQuery(className: "UserImage")
            
            query.whereKey("recipient", equalTo: activeUser)
            
            query.findObjectsInBackgroundWithBlock { (imagesList, error:NSError?) -> Void in
                
                if error == nil {
                    
                    let pfObjects = imagesList as? [PFObject]!
                        
                    if pfObjects!.count > 0 {
                        
                        let imageView: PFImageView = PFImageView()
                        
                        imageView.file = pfObjects![0]["photo"] as! PFFile
                        
                        imageView.loadInBackground({(photo, error) -> Void in
                        
                            if error == nil {
                            
                                var senderUsername = "Unknown User"
                                
                                if let username = pfObjects![0]["sender"] as? String {
                                
                                    senderUsername = username
                                    
                                }
                                
                                let alert = UIAlertController(title: "You have a message", message: "Message from \(senderUsername)", preferredStyle: .Alert)
                                
                                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
                                    
                                    let bgImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
                                    
                                    bgImage.backgroundColor = UIColor.blackColor()
                                    
                                    bgImage.alpha = 0.8
                                    
                                    bgImage.tag = 10
                                    
                                    bgImage.contentMode = .ScaleAspectFit
                                    
                                    self.view.addSubview(bgImage)
                                    
                                    
                                    
                                    let displayedImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
                                    
                                    displayedImage.image = photo
                                    
                                    displayedImage.tag = 10
                                    
                                    displayedImage.contentMode = .ScaleAspectFit
                                    
                                    self.view.addSubview(displayedImage)
                                    
                                    do {
                                    
                                        try pfObjects![0].delete()
                                        
                                    } catch {}
                                    
                                    
                                    
                                    _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.hideMessage), userInfo: nil, repeats: false)
                                    
                                }))
                                
                                self.presentViewController(alert, animated: true, completion: nil)
                                
                            } else {
                            
                                
                            }
                            
                        })
                        
                    }
                    
                }
                
            }
        
        }
        
    }
    
    
    func hideMessage() {
        
        for subview in self.view.subviews {
        
            if subview.tag == 10 {
            
                subview.removeFromSuperview()
                
            }
            
        }
        
    }
    

    override func viewDidLoad() {

        super.viewDidLoad()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.checkForMessage), userInfo: nil, repeats: true)
        
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
        
        
        let acl = PFACL()
        
        acl.publicReadAccess = true
        
        acl.publicWriteAccess = true
        
        
        let imageToSend = PFObject(className: "UserImage")
        
        imageToSend["photo"] = PFFile(name: "photo.jpe", data: UIImageJPEGRepresentation(image, 0.5)!)
        
        imageToSend["sender"] = PFUser.currentUser()?.username
        
        imageToSend["recipient"] = self.recipientUsername
        
        imageToSend.ACL = acl
        
        imageToSend.saveInBackgroundWithBlock { (isSaved, error:NSError?) -> Void in
            
            if error == nil {
            
                print("Image was succesfully uploaded to Parse")
                
            } else {
            
                print("Parse upload image error: \(error?.localizedDescription)")
                
            }
            
        }
    }

}
