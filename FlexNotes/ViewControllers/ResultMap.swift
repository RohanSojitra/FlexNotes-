//
//  ResultMap.swift
//  FlexNotes
//
//  Created by Anil on 19/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ResultMap: UIViewController {

    //MARK:- Var Declaration --
    
    var Lat = 0.0
    var Long = 0.0
    
    //MARK:- Outlets --
    
    @IBOutlet weak var MapView: MKMapView!
    
    //MARK:- View LifeCycle --
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Redirect to Apple Map with Route
        let Location1 = CLLocationCoordinate2D(latitude: Lat, longitude: Long)
        let Destination = MKMapItem(placemark: MKPlacemark(coordinate: Location1))
            Destination.name = "Destination"
        MKMapItem.openMaps(with: [Destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault])
        
    }
    
}
