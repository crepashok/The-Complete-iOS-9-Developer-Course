//
//  ViewController.swift
//  Lecture-87
//
//  Created by Pavlo Cretsu on 3/17/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        let audioPath = NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")
        
        
    
    }

    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

