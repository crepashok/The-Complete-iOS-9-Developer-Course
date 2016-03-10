//
//  SecondViewController.swift
//  Lecture-58
//
//  Created by Pavlo Cretsu on 3/10/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newItemTextField: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    @IBAction func addItem(sender: UIButton) {
        
        if newItemTextField.text?.characters.count > 0 {
            
            toDoList.append(newItemTextField.text!)
            
            newItemTextField.text = ""
            
            infoLabel.text = "New ToDo item was successfully added"
            
            NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
            
        } else {
        
            infoLabel.text = "New ToDo item was not added because of empty item name"
            
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.newItemTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    
        newItemTextField.resignFirstResponder()
        
        return true
        
    }

}


