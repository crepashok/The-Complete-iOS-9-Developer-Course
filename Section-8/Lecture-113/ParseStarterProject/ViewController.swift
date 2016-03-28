/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let product = PFObject(className:"Products")
        
        product["name"] = "Ice cream"
        
        product["description"] = "Tutti Fruitti"
        
        product["price"] = 4.99
        
        product.saveInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
            
            if (success) {
                
                print("Object was saved with ID \(product.objectId)")
                
            } else {
                
                print("Failed: \(error?.localizedDescription)")
                
            }
        }*/
        
        let query = PFQuery(className: "Products")
        
        query.getObjectInBackgroundWithId("uFuweBq1Y9") { (object: PFObject?, error: NSError?) -> Void in
            
            if error != nil {
            
                print("Query error: \(error?.localizedDescription)")
                
            } else if let product = object {
                
                product["description"] = "Rocky Road"
                
                product["price"] = 5.99
                
                product.saveInBackground()
                
                print(product.objectForKey("description"))
                
            }
            
        }
        
    }
    
}
