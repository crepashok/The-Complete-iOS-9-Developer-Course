//
//  ViewController.swift
//  Lecture-103
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        /*let url = NSURL(string: "http://www.ecowebhosting.co.uk")
        
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)*/
        
        let html = "<html><body><h1>MyPage</h1><p>This Is My Web Page</body></html>"
        
        webView.loadHTMLString(html, baseURL: nil)
    
    }
    
}

