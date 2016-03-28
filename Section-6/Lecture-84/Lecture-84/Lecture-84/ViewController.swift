//
//  ViewController.swift
//  Lecture-84
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var player: AVAudioPlayer = AVAudioPlayer()

    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var scrubSlider: UISlider!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initPlayer()
        
    }
    
    
    private func initPlayer() {
        
        if let audioPath = NSBundle.mainBundle().pathForResource("Feel", ofType: "mp3") {
            
            do {
                
                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
                
                player.volume = slider.value
                
                scrubSlider.maximumValue = Float(player.duration)
                
                _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateScrubSlider"), userInfo: nil, repeats: true)
                
            } catch {
                
                // Process errors here
                
            }
            
        }
    }
    
    

    @IBAction func play(sender: UIBarButtonItem) {
        
        player.play()
        
    }
    

    @IBAction func pause(sender: UIBarButtonItem) {
        
        player.pause()
        
    }
    
    
    @IBAction func stop(sender: UIBarButtonItem) {
        
        player.stop()
        
        initPlayer()
        
    }
    
    
    @IBAction func adjustVolume(sender: UISlider) {
        
        player.volume = slider.value
        
    }
    
    
    @IBAction func scrub(sender: UISlider) {
        
        player.currentTime = Double(scrubSlider.value)
        
    }
    
    
    func updateScrubSlider() {
    
        scrubSlider.value = Float(player.currentTime)
        
    }
}

