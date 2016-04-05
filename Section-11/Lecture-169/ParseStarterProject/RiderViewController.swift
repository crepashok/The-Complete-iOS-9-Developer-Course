//
//  RiderViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderViewController: UIViewController, CLLocationManagerDelegate {

    
    var locationManager:CLLocationManager!
    
    var latitude:CLLocationDegrees = 0
    
    var longitude:CLLocationDegrees = 0
    
    var riderRequestActive = false
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    @IBOutlet weak var callUberButton: UIButton!
    
    
    
    @IBAction func callUber(sender: UIButton) {
        
        if riderRequestActive {
            
            let riderRequest = PFObject(className:"RiderRequest")
            
            riderRequest["username"] = PFUser.currentUser()?.username
            
            riderRequest["location"] = PFGeoPoint(latitude:latitude, longitude:longitude)
            
            riderRequest.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                
                if (success) {
                    
                    self.callUberButton.setTitle("Cancel Uber", forState: .Normal)
                    
                } else {
                    
                    self.displayAlertWith("Could not call Uber", message: "Please try again later!")
                    
                }
                
            }
        
        } else {
            
            let query = PFQuery(className:"RiderRequest")
            
            query.whereKey("username", equalTo:(PFUser.currentUser()?.username)!)
            
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                
                self.callUberButton.setTitle("Call an Uber", forState: .Normal)
                
                if error == nil {
                    
                    if let objects = objects {
                        for object in objects {
                            object.deleteInBackground()
                        }
                    }
                    
                } else {
                    
                    print("Error: \(error!) \(error!.userInfo)")
                    
                }
                
            }
        
        }
        
        riderRequestActive = !riderRequestActive
        
    }
    
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        
        latitude = location.latitude
        
        longitude = location.longitude
        
        
        
        
        
        
        
        let query = PFQuery(className:"RiderRequest")
        
        query.whereKey("username", equalTo:(PFUser.currentUser()?.username)!)
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        print(object)
                        
                        if let driverUsername = object["driverResponded"] {
                            
                            self.callUberButton.setTitle("Driver is on the way!", forState: .Normal)
                            
                            
                            
                            
                            
                            
                            
                            let driverLocationQuery = PFQuery(className:"DriverLocation")
                            
                            driverLocationQuery.whereKey("username", equalTo:driverUsername)
                            
                            driverLocationQuery.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    
                                    if let obj = objects as [PFObject]! {
                                        
                                        for object in obj {
                                            
                                            if let driverLocation = object["driverLocation"] as? PFGeoPoint {
                                                
                                                print(driverLocation)
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                        
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        
        map.removeAnnotations(map.annotations)
        
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        
        let objectAnnotation = MKPointAnnotation()
        
        objectAnnotation.coordinate = pinLocation
        
        objectAnnotation.title = "Your location"
        
        self.map.addAnnotation(objectAnnotation)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logoutRider" {
            
            PFUser.logOut()
            
        }
        
    }
    
    
    
    func displayAlertWith(title: String, message: String, actionTitle: String = "Ok") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
