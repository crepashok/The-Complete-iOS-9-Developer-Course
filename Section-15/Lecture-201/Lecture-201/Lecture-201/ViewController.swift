//
//  ViewController.swift
//  Lecture-201
//
//  Created by Pavlo Cretsu on 4/6/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let authenticationContext = LAContext()
        
        var error:NSError?
        
        if authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            authenticationContext.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "We need to know who you are...") { (success, error) -> Void in
                
                if success {
                    
                    // User has auth
                    
                } else {
                    
                    if let error = error {
                        
                        // There was an error
                        print("Authentication error: \(error.localizedDescription)")
                        
                    } else {
                        
                        // User did not auth
                        
                    }
                    
                }
                
            }
        
        } else {
        
            // No touch ID available
            
        }
        
    }

}

