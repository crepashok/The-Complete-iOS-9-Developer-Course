//
//  ViewController.swift
//  Lecture-75
//
//  Created by Pavlo Cretsu on 3/11/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let latitude:CLLocationDegrees = 48.281773
        
        let longitude:CLLocationDegrees = 25.934869
        
        let latDelta:CLLocationDegrees = 0.02
        
        let lonDelta:CLLocationDegrees = 0.02
        
        let mapSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, mapSpan)
        
        mapView.setRegion(region, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

