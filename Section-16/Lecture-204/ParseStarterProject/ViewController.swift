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

class ViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func signUp(sender: UIButton) {
        
        
        PFUser.logInWithUsernameInBackground(username.text!, password: "password") { (user: PFUser?, error: NSError?) -> Void in
            
            if let _ = error {
            
                let user = PFUser()
                
                user.username = self.username.text!
                
                user.password = "password"
                
                user.signUpInBackgroundWithBlock({ (succedded: Bool, error: NSError?) -> Void in
                    
                    if let error = error {
                    
                        let errorString = error.userInfo["error"]! as! String
                        
                        self.errorLabel.text = "Parse Error: \(errorString)"
                        
                    } else {
                    
                        print("Signed Up!")
                        
                        self.errorLabel.text = ""
                        
                        self.performSegueWithIdentifier("ShowUserTable", sender: self)
                        
                    }
                    
                })
                
            } else {
                
                print("Logged In!")
                
                self.errorLabel.text = ""
                
                self.performSegueWithIdentifier("ShowUserTable", sender: self)
                
            }
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.hidden = true
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser()?.username != nil {
            
            self.performSegueWithIdentifier("ShowUserTable", sender: self)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
}
