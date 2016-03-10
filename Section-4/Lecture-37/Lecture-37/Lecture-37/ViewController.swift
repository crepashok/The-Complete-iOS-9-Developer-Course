//
//  ViewController.swift
//  Lecture-37
//
//  Created by Pavlo Cretsu on 3/10/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func isItPrime(sender: AnyObject) {
        
        if let number = Int(numberTextField.text!) {
            
            resultLabel.text = (isPrime(number)) ? "\(number) Is Prime!" : "\(number) is not prime"
        
        } else {
            
            resultLabel.text = "Please enter a whole number"
            
        }
        
    }
    
    func isPrime(n: Int) -> Bool{
        
        if (n < 2){
            return false
        }
            
        else if (n == 2){
            return true
        }
            
        else if (n % 2 == 0){
            return false
        }
        
        if n != 2 && n != 1 {
            
            for var i = 2; i < n; i++ {
                
                if n % i == 0 {
                    
                    return false
                    
                }
                
            }
            
        }
        
        return true
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

