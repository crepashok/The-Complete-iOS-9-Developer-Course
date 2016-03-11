//
//  ViewController.swift
//  Lecture-69
//
//  Created by Pavlo Cretsu on 3/11/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alienImage: UIImageView!
    
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    
    @IBOutlet weak var stopButton: UIBarButtonItem!
    
    var timer = NSTimer()
    
    let allImages = [
        "a18-0.png",
        "a18-1.png",
        "a18-2.png",
        "a18-3.png",
    ]
    
    var activeIndex = 0
    
    
    func animatePNGImage() {
        
        if activeIndex < allImages.count - 1 {
            
            activeIndex++
        
        } else {
            
            activeIndex = 0
            
        }
        
        self.alienImage.image = UIImage(named: allImages[activeIndex])
        
    }
    
    
    @IBAction func play(sender: UIBarButtonItem) {
        
        self.pauseButton.enabled = true
        
        self.playButton.enabled = false
        
        timer.invalidate()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("animatePNGImage"), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func pause(sender: UIBarButtonItem) {
        
        self.pauseButton.enabled = false
        
        self.playButton.enabled = true
        
        timer.invalidate()
        
    }
    
    
    @IBAction func stop(sender: UIBarButtonItem) {
        
        timer.invalidate()
        
        activeIndex = -1
        
        animatePNGImage()
        
        self.pauseButton.enabled = false
        
        self.playButton.enabled = true
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.alienImage.image = UIImage(named: allImages[activeIndex])
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

