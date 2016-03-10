//
//  ViewController.swift
//  Lecture-60
//
//  Created by Pavlo Cretsu on 3/10/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url = NSURL(string: "http://stackoverflow.com")!
        
        self.webView.loadRequest(NSURLRequest(URL: url))
        
        /*let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            // Will happen when task is completted
            if let urlContent = data {
                
                if let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding) {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.webView.loadHTMLString(String(webContent), baseURL:nil)
                        
                    })
                    
                }
                
            } else {
            
                // Show error message
                
            }
            
        }
        
        task.resume()*/
        
    }
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

