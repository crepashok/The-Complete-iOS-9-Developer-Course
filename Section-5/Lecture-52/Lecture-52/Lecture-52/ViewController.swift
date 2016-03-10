//
//  ViewController.swift
//  Lecture-52
//
//  Created by Pavlo Cretsu on 3/10/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setObject("Rob", forKey: "name")
        
        if let userName = userDefaults.objectForKey("name") {
            
            print(userName)
        
        }
        
        let arr = [1, 2, 3, 4]
        
        userDefaults.setObject(arr, forKey: "array")
        
        if let arrayData = userDefaults.objectForKey("array") {
            
            let nsArrayData = arrayData as! NSArray
            
            for x in nsArrayData {
            
                print(x)
                
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

