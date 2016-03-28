//
//  ViewController.swift
//  Lecture-88
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer.init(target: self, action: "swiped:")
        swipeRight.direction = .Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer.init(target: self, action: "swiped:")
        swipeUp.direction = .Up
        self.view.addGestureRecognizer(swipeUp)
        
        
        
        
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.MotionShake {
        
            print("Device was shaken")
            
        }
        
    }
    
    
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Up:
                print("Swiped Up")
                
            case UISwipeGestureRecognizerDirection.Down:
                print("Swiped Down")
                
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped Left")
                
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped Right")
                
            default:
                print("Unspecified gesture recogniser")
                break
            }
            
        }
    
    }
    
    

}

