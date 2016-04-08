//
//  SignUpViewController.swift
//  ParseStarterProject
//
//  Created by Pavlo Cretsu on 4/8/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var interestedInWomen: UISwitch!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])
        
        graphRequest.startWithCompletionHandler { (connection, result, error) in
            
            if error != nil {
            
                print("Graph request error: \(error.localizedDescription)")
                
            } else if let result = result {
                
                print(result)
                
            }
            
        }
        
    }

    @IBAction func signUp(sender: AnyObject) {
        
    }
    
}
