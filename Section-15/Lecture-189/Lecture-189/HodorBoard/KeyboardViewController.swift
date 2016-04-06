//
//  KeyboardViewController.swift
//  HodorBoard
//
//  Created by Pavlo Cretsu on 4/6/16.
//  Copyright © 2016 Pavlo Cretsu. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    
    @IBOutlet var nextKeyboardButton: UIButton!

    
    override func updateViewConstraints() {
        
        super.updateViewConstraints()
        
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let button = UIButton(type: .System) as UIButton
        button.frame = CGRectMake(150, 40, 100, 120)
        button.setBackgroundImage(UIImage(named: "hodor.png"), forState: .Normal)
        button.addTarget(self, action: "didPressButton", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .System)
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        self.nextKeyboardButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        self.nextKeyboardButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    }
    
    func didPressButton() {
        
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText("Hodor")
        
    }
    

    override func textWillChange(textInput: UITextInput?) {
        
        // The app is about to change the document's contents. Perform any preparation here.
        
    }

    
    override func textDidChange(textInput: UITextInput?) {
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
