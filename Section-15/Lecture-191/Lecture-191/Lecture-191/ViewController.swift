//
//  ViewController.swift
//  Lecture-191
//
//  Created by Pavlo Cretsu on 4/6/16.
//  Copyright © 2016 Pavlo Cretsu. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController {
    
    
    @IBOutlet weak var adBanner: ADBannerView!
    
    @IBOutlet weak var removeButton: UIButton!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
    }
    

    @IBAction func removeAd(sender: AnyObject) {
        
        adBanner.removeFromSuperview()
        
        removeButton.removeFromSuperview()
    }
}

