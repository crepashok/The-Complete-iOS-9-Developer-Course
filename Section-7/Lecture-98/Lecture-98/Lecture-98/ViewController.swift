//
//  ViewController.swift
//  Lecture-98
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var documentsDirectory:String?
        
        let paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            
            documentsDirectory = paths.first as? String
            
            let savePath = documentsDirectory! + "/bach.jpg"
            
            self.imageView.image = UIImage(named: savePath)
            
        }
        
        /*let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, responce, error) -> Void in
            
            if error != nil {
            
                print("NSURLSession error: \(error)")
            
            } else {
                
                var documentsDirectory:String?
                
                let paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                
                if paths.count > 0 {
                
                    documentsDirectory = paths.first as? String
                    
                    let savePath = documentsDirectory! + "/bach.jpg"
                    
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.imageView.image = UIImage(named: savePath)
                        
                    })
                    
                }
                
            }
            
        }
        
        task.resume()*/
    }
}

