//
//  ViewController.swift
//  Lecture-94
//
//  Created by Pavlo Cretsu on 3/28/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appDel:AppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
        
            let context:NSManagedObjectContext = appDel.managedObjectContext
            
            /*let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
            
            newUser.setValue("Tommy", forKey: "username")
            
            newUser.setValue("pppass123", forKey: "password")
            
            newUser.setValue("Yurievich", forKey: "surname")
            
            do {
            
                try context.save()
                
            } catch {
                
                print("There was a problem!")
                
            }*/
            
            let request = NSFetchRequest(entityName: "Users")
            
            //request.predicate = NSPredicate(format: "username = %@", "Tommy")
            
            request.returnsObjectsAsFaults = false
            
            do {
                
                let results = try context.executeFetchRequest(request)
                
                if results.count > 0 {
                
                    for result in results as! [NSManagedObject] {
                        
                        context.deleteObject(result)
                        
                        //result.setValue("Raphie", forKey: "username")
                        
                        /*do {
                            
                            try context.save()
                            
                        } catch {
                            
                            print("There was a update entity problem!")
                            
                        }*/
                        
                        if let username = result.valueForKey("username") as? String {
                            
                            print("returned value: \(username)")
                        
                        }
                        
                    }
                    
                }
                
                //print("results = \(results)")
                
            } catch {
                
                print("There was a problem!")
                
            }
            
        }
        
    }

}

