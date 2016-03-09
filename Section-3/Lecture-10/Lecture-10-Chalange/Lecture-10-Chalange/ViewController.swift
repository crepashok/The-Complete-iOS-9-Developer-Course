//
//  ViewController.swift
//  Lecture-10-Chalange
//
//  Created by Pavlo Cretsu on 3/9/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func submit(sender: AnyObject) {
        
        print("Button tapped")
        
        label.text = "How old are you?"
        
        if let ageValue:String = textField.text {
            
            if ageValue.characters.count > 0 && Int(ageValue) > 0 {
                
                responseLabel.text = "I am \(ageValue)"
                
            } else {
                
                responseLabel.text = "Oh sorry, I've setted wrong age value"
                
            }
            
        } else {
            
            responseLabel.text = "I have to think..."
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("Hello Rob!")
    }

    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

