//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        PFUser.logOut()
        
        if let username = PFUser.currentUser()?.username {
        
            self.performSegueWithIdentifier("showSignInScreen", sender: self)
            
        }
        
    }
    
    
    @IBAction func signIn(sender: AnyObject) {
        
        let permissions = ["public_profile"]
        
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {
            
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                
                print(error)
                
            } else {
                
                if let user = user {
                    
                    print(user)
                    
                    
                }
                
            }
            
        })
        
    }
}

