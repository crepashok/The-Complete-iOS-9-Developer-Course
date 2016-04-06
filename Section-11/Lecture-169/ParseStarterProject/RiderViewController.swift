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
    
    var driverOnTheWay = false
    
    
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
        
        if let currentUserLogin = PFUser.currentUser()?.username {
            
            let query = PFQuery(className:"RiderRequest")
            
            query.whereKey("username", equalTo:currentUserLogin)
            
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    if let objects = objects {
                        
                        for object in objects {
                            
                            print(object)
                            
                            if let driverUsername = object["driverResponded"] {
                                
                                let driverLocationQuery = PFQuery(className:"DriverLocation")
                                
                                driverLocationQuery.whereKey("username", equalTo:driverUsername)
                                
                                driverLocationQuery.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                                    
                                    if error == nil {
                                        
                                        if let obj = objects as [PFObject]! {
                                            
                                            for object in obj {
                                                
                                                if let driverLocation = object["driverLocation"] as? PFGeoPoint {
                                                    
                                                    let driverCLLocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                                                    
                                                    let userCLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                                                    
                                                    let distanceMeters = userCLLocation.distanceFromLocation(driverCLLocation)
                                                    
                                                    let distanceKM = distanceMeters / 1000
                                                    
                                                    let roundedTwoDigitDistance = Double(round(distanceKM * 10) / 10)
                                                    
                                                    self.callUberButton.setTitle("Driver is \(roundedTwoDigitDistance)km away!", forState: .Normal)
                                                    
                                                    
                                                    
                                                    
                                                    self.driverOnTheWay = true
                                                    
                                                    
                                                    
                                                    let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                                                    
                                                    let latDelta = abs(driverLocation.latitude - location.latitude) * 2 + 0.001
                                                    
                                                    let lonDelta = abs(driverLocation.longitude - location.longitude) * 2 + 0.001
                                                    
                                                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
                                                    
                                                    self.map.setRegion(region, animated: true)
                                                    
                                                    
                                                    self.map.removeAnnotations(self.map.annotations)
                                                    
                                                    
                                                    var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                                                    
                                                    var objectAnnotation = MKPointAnnotation()
                                                    
                                                    objectAnnotation.coordinate = pinLocation
                                                    
                                                    objectAnnotation.title = "Your location"
                                                    
                                                    self.map.addAnnotation(objectAnnotation)
                                                    
                                                    
                                                    pinLocation = CLLocationCoordinate2DMake(driverLocation.latitude, driverLocation.longitude)
                                                    
                                                    objectAnnotation = MKPointAnnotation()
                                                    
                                                    objectAnnotation.coordinate = pinLocation
                                                    
                                                    objectAnnotation.title = "Driver location"
                                                    
                                                    self.map.addAnnotation(objectAnnotation)
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
            
            if self.driverOnTheWay == false {
            
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
        
        }
        
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
