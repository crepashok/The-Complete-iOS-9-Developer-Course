//
//  ViewController.swift
//  Lecture-197
//
//  Created by Pavlo Cretsu on 4/6/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
        
            registerForPreviewingWithDelegate(self, sourceView: view)
            
        } else {
        
            print("3D touch not available")
            
        }
    
    }

}

extension ViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let peekViewController = storyboard?.instantiateViewControllerWithIdentifier("PeekViewController") as! PeekViewController
        
        return peekViewController
        
    }
    
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        let popViewController = storyboard?.instantiateViewControllerWithIdentifier("PopViewController") as! PeekViewController
        
        showViewController(popViewController, sender: self)
        
    }
    
}