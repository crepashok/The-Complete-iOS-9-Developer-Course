//
//  DetailViewController.swift
//  Lecture-105
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        
        if let detail = self.detailItem {
            
            if let postWebView = self.webView {
                
                postWebView.loadHTMLString(detail.valueForKey("content")!.description, baseURL: nil)
                
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

