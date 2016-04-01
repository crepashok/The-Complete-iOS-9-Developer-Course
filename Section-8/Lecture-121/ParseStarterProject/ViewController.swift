/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var signUpActive = true
    

    @IBOutlet weak var username: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var registeredText: UILabel!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    @IBAction func signUp(sender: UIButton) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in form", message: "Please enter a username and password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            
            activityIndicator.center = self.view.center
            
            activityIndicator.hidesWhenStopped = true
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Please, try again later"
            
            if signUpActive == true {
                
                let user = PFUser()
                
                user.username = username.text
                
                user.password = password.text
                
                user.signUpInBackgroundWithBlock({ (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        // SignUp successfull
                        
                        self.username.text = ""
                        
                        self.password.text = ""
                        
                        self.username.resignFirstResponder()
                        
                        self.password.resignFirstResponder()
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                        }
                        
                        self.displayAlert("Failed SignUp", message: errorMessage)
                        
                    }
                    
                })
            
            } else {
            
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                    
                        if let errorString = error!.userInfo["error"] as? String {
                        
                            errorMessage = errorString
                            
                        }
                        
                        self.displayAlert("Failed Login", message: errorMessage)
                        
                    }
                    
                })
                
            }
            
        }
        
    }
    
    
    func displayAlert(title: String, message: String) {
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func logIn(sender: UIButton) {
        
        if signUpActive == true {
        
            signUpButton.setTitle("Log In", forState: UIControlState.Normal)
            
            registeredText.text = "Not Registered?"
            
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signUpActive = false
            
        } else {
            
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            registeredText.text = "Already registered?"
            
            loginButton.setTitle("Log In", forState: UIControlState.Normal)
            
            signUpActive = true
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        if let curentUser = PFUser.currentUser() {
            
            print(curentUser)
            
            self.performSegueWithIdentifier("login", sender: self)
        
        }
    }
    
}
