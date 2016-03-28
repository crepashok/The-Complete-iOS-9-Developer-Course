//
//  ViewController.swift
//  Lecture-90
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    
    let sounds = ["bear", "birds", "cat", "horses"]
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.MotionShake {
            
            let randomNumber = Int(arc4random_uniform(UInt32(sounds.count)))
            
            let fileLocation = NSBundle.mainBundle().pathForResource(sounds[randomNumber], ofType: "mp3")
            
            do {
                
                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: fileLocation!))
                
                player.play()
                
            } catch {
            
            }
            
        }
        
    }


}

