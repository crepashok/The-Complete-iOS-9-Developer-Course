//
//  ViewController.swift
//  Lecture-101
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url = NSURL(string: "http://geoip.nekudo.com/api/8.8.8.8")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, responce, error) -> Void in
            
            if error != nil {
                
                print("NSURLSession error: \(error)")
                
            } else {
                
                if let urlContent = data {
                
                    do {
                    
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                        
                        print(jsonResult)
                        
                        print(jsonResult["city"])
                        
                    } catch {
                    
                        print("NSJSONSerialization failed")
                        
                    }
                    
                }
                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in  
//                })
                
            }
        }
        
        task.resume()
        
    }
    
        
}

