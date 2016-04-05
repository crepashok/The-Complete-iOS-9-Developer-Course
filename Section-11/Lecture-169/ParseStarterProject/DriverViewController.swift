//
//  DriverViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pavlo Cretsu on 4/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit


class DriverViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    var usernames = [String]()
    
    var locations = [CLLocationCoordinate2D]()
    
    var distances = [CLLocationDistance]()
    
    var locationManager:CLLocationManager!
    
    var latitude:CLLocationDegrees = 0
    
    var longitude:CLLocationDegrees = 0
    
    
    
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
        
        self.latitude = location.latitude
        
        self.longitude = location.longitude
        
        let query = PFQuery(className:"RiderRequest")
        
        query.whereKey("location", nearGeoPoint:PFGeoPoint(latitude:location.latitude, longitude:location.longitude))
        
        query.limit = 15
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    
                    self.usernames.removeAll()
                    
                    self.locations.removeAll()
                    
                    self.distances.removeAll()
                    
                    for object in objects {
                        
                        if object["driverResponded"] == nil {
                            
                            if let username = object["username"] as? String {
                                
                                self.usernames.append(username)
                                
                            }
                            
                            if let returnedLocation = object["location"] as? PFGeoPoint {
                                
                                let requestLocation = CLLocationCoordinate2DMake(returnedLocation.latitude, returnedLocation.longitude)
                                
                                self.locations.append(requestLocation)
                                
                                let requestCLLocation = CLLocation(latitude: requestLocation.latitude, longitude: requestLocation.longitude)
                                
                                let driverCLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                                
                                let distance = driverCLLocation.distanceFromLocation(requestCLLocation)
                                
                                self.distances.append(distance/1000)
                                
                            }
                        
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            } else {
                
                print("Error: \(error!) \(error!.userInfo)")
                
            }
            
        }
    }

    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usernames.count
        
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let distanceDouble = Double(distances[indexPath.row])
        
        let roundedDustance = Double(round(distanceDouble * 10) / 10)

        cell.textLabel?.text = "\(usernames[indexPath.row])  \(roundedDustance)km away"
        
        return cell
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logoutDriver" {
            
            navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
            
            PFUser.logOut()
            
        } else if segue.identifier == "showViewRequests" {
        
            if let destination = segue.destinationViewController as? RequestViewController {
                
                destination.requestLocation = locations[(tableView.indexPathForSelectedRow?.row)!]
                
                destination.requestUsername = usernames[(tableView.indexPathForSelectedRow?.row)!]
                
            }
            
        }
        
    }
    

}
