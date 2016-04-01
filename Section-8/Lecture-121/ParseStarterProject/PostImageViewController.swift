//
//  PostImageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imagePost: UIImageView!
    
    @IBOutlet weak var message: UITextField!
    
    var activityIndicator = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func choiseImage(sender: UIButton) {
        
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion:  nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.imagePost.image = image
        
    }
    
    
    @IBAction func postImage(sender: UIButton) {
        
        var isValid = true
        
        if self.imagePost.image == UIImage(named: "placeholder.png") {
            
            self.displayAlert("Could not post image", message: "Please set some Image first and try again")
            
            isValid = false
            
        }
        
        if self.message.text == "" {
            
            self.displayAlert("Could not post image", message: "Please set some Image description and try again")
            
            isValid = false
            
        }
        
        if isValid == true {
            
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            
            activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            
            activityIndicator.center = view.center
            
            activityIndicator.hidesWhenStopped = true
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            let post = PFObject(className: "Post")
            
            post["message"] = message.text
            
            post["userId"] = PFUser.currentUser()!.objectId!
            
            if let imageData = UIImageJPEGRepresentation(imagePost.image!, 1.0)  {
                
                let imageFile = PFFile(name: "image.png", data: imageData)
                
                post["imageFile"] = imageFile
                
                post.saveInBackgroundWithBlock { (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        self.imagePost.image = UIImage(named: "placeholder.png")
                        
                        self.message.text = ""
                        
                        self.displayAlert("Image Posted", message: "Your image has been posted successfully")
                        
                    } else {
                        
                        self.displayAlert("Could not post image", message: "Please try again later")
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
}
