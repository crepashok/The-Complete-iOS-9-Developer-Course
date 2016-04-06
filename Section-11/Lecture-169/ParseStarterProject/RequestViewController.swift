//
//  RequestViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MapKit
import Parse


class RequestViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var requestLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    
    var requestUsername:String = ""

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = requestUsername
        
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        let objectAnnotation = MKPointAnnotation()
        
        objectAnnotation.coordinate = requestLocation
        
        objectAnnotation.title = requestUsername
        
        self.map.addAnnotation(objectAnnotation)
    }
    
    
    
    @IBAction func pickUpRider(sender: UIButton) {
        
        if let currentUsername = PFUser.currentUser()?.username {
            
            let query = PFQuery(className:"RiderRequest")
            
            query.whereKey("username", equalTo:requestUsername)
            
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    if let objects = objects {
                        
                        for object in objects {
                            
                            let updateQuery = PFQuery(className:"RiderRequest")
                            
                            updateQuery.getObjectInBackgroundWithId(object.objectId!) { (object: PFObject?, riderError: NSError?) -> Void in
                                
                                if let newRiderError = riderError {
                                    
                                    print(newRiderError.localizedDescription)
                                    
                                } else if let object = object {
                                    
                                    object["driverResponded"] = currentUsername
                                    
                                    object.saveInBackground()
                                    
                                    let requestCLLocation = CLLocation(latitude: self.requestLocation.latitude, longitude: self.requestLocation.longitude)
                                    
                                    CLGeocoder().reverseGeocodeLocation(requestCLLocation, completionHandler: { (placemarks, error) -> Void in
                                        
                                        if error != nil {
                                            
                                            print("Reverse geocoder failed with error: \(error?.localizedDescription)")
                                            
                                        } else {
                                            
                                            if placemarks!.count > 0 {
                                                
                                                let pm = placemarks![0] as! CLPlacemark
                                                
                                                let mkPm = MKPlacemark(placemark: pm)
                                                
                                                let mapItem = MKMapItem(placemark: mkPm)
                                                
                                                mapItem.name = self.requestUsername
                                                
                                                let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                                                
                                                mapItem.openInMapsWithLaunchOptions(launchOptions)
                                                
                                            } else {
                                                
                                                print("Problem with the data received from geocoder")
                                                
                                            }
                                            
                                        }
                                        
                                    })
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                } else {
                    
                    print("Error: \(error!) \(error!.userInfo)")
                    
                }
                
            }
        
        }
        
    }
    
}
