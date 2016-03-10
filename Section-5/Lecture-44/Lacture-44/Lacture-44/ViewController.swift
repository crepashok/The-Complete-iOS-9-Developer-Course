//
//  ViewController.swift
//  Lacture-44
//
//  Created by Pavlo Cretsu on 3/10/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var time = 0
    
    var timer = NSTimer()
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    
    func increaseTimer() {
    
        resultLabel.text = "\(++time) sec."
        
    }
    
    func resetTimer() {
    
        time = 0;
        
        resultLabel.text = "0 sec."
        
        playButton.tag = 0
        
        applyPlayButtonStyle()
        
    }
    
    func applyPlayButtonStyle() {
        
        playButton.tintColor = (playButton.tag == 0) ? UIColor.init(red: 13.0 / 255.0, green: 95.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0) : UIColor.grayColor()
        
    }
    
    
    @IBAction func startTimerButtonClick(sender: UIBarButtonItem) {
        
        if sender.tag == 0 {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseTimer"), userInfo: nil, repeats: true)
            
        } else {
            
            timer.invalidate()
            
        }
        
        sender.tag = (sender.tag == 1) ? 0 : 1
        
        applyPlayButtonStyle()
        
    }

    
    @IBAction func pauseTimerButtonClick(sender: UIBarButtonItem) {
        
        timer.invalidate()
        
        resetTimer()
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}

