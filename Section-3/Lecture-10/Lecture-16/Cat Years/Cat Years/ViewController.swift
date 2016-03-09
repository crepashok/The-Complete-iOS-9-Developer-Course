//
//  ViewController.swift
//  Cat Years
//
//  Created by Pavlo Cretsu on 3/9/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catAgeTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findAge(sender: AnyObject) {
        
        resultLabel.text = catAgeTextField.text
        
        if let ageValue:String = catAgeTextField.text {
            
            if ageValue.characters.count > 0 && Int(ageValue) > 0 {
                
                var catAge = Int(ageValue)!
                
                catAge = catAge * 7
                
                catAgeTextField.text = ""
                
                catAgeTextField.resignFirstResponder()
                
                resultLabel.text = "Your cat is \(catAge) in cat years"
                
            } else {
                
                resultLabel.text = "Oh sorry, I've setted wrong age value"
                
            }
            
        } else {
            
            resultLabel.text = "I have to ask..."
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

