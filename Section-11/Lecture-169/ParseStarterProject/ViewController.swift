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

class ViewController: UIViewController, UITextFieldDelegate {
    
    var signUpState = true

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var rolesSwitcher: UISwitch!
    
    @IBOutlet weak var driverLabel: UILabel!
    
    @IBOutlet weak var riderLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var toggleSignupButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        username.delegate = self
        
        password.delegate = self
        
    }
    
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
    
    
    @IBAction func signUp(sender: UIButton) {
        
        if username.text == "" || password.text == "" {
        
            displayAlertWith("Missing Field(s)", message: "Username and Password are required")
            
        } else {
            
            if signUpState == true {
                
                let user = PFUser()
                
                user.username = username.text
                
                user.password = password.text
                
                user["isDriver"] = rolesSwitcher.on
                
                user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
                    
                    if let error = error {
                        
                        self.displayAlertWith("Sign Up Failed", message: error.localizedDescription)
                        
                    } else {
                        
                        self.performSegueWithIdentifier("loginRider", sender: self)
                        
                    }
                    
                }
            
            } else {
                
                PFUser.logInWithUsernameInBackground(self.username.text!, password:self.password.text!) { (user: PFUser?, error: NSError?) -> Void in
                    
                    if user != nil {
                        
                        self.performSegueWithIdentifier("loginRider", sender: self)
                        
                    } else {
                        
                        if let error = error {
                            
                            self.displayAlertWith("Sign Up Failed", message: error.localizedDescription)
                        
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    @IBAction func toggleSignup(sender: UIButton) {
        
        if signUpState == true {
            
            signUpButton.setTitle("Log in", forState: .Normal)
            
            toggleSignupButton.setTitle("Switch to Sign Up", forState: .Normal)
            
            riderLabel.alpha = 0
            
            driverLabel.alpha = 0
            
            rolesSwitcher.alpha = 0
        
        } else {
            
            signUpButton.setTitle("Sign Up", forState: .Normal)
            
            toggleSignupButton.setTitle("Switch to Login", forState: .Normal)
            
            riderLabel.alpha = 1
            
            driverLabel.alpha = 1
            
            rolesSwitcher.alpha = 1
            
        }
        
        signUpState = !signUpState
        
        
    }
    
    
    
    func displayAlertWith(title: String, message: String, actionTitle: String = "Ok") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return false
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser()?.username != nil {
            
            self.performSegueWithIdentifier("loginRider", sender: self)
        
        } else {
        
        }
        
    }
    
    
}
