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
                    
                        // Logged in!
                        
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
        
        /*let product = PFObject(className:"Products")
        
        product["name"] = "Ice cream"
        
        product["description"] = "Tutti Fruitti"
        
        product["price"] = 4.99
        
        product.saveInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
            
            if (success) {
                
                print("Object was saved with ID \(product.objectId)")
                
            } else {
                
                print("Failed: \(error?.localizedDescription)")
                
            }
        }*/
        
        /*let query = PFQuery(className: "Products")
        
        query.getObjectInBackgroundWithId("uFuweBq1Y9") { (object: PFObject?, error: NSError?) -> Void in
            
            if error != nil {
            
                print("Query error: \(error?.localizedDescription)")
                
            } else if let product = object {
                
                product["description"] = "Rocky Road"
                
                product["price"] = 5.99
                
                product.saveInBackground()
                
                print(product.objectForKey("description"))
                
            }
            
        }*/
        
    }
    
}
