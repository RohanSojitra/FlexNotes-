//
//  TestViewController.swift
//  FlexNotes
//
//  Created by Anil on 19/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ResultViewController: UIViewController {

    //MARK:- variable Declaration --
    
    var Image1 = UIImage()
    var Title1 = ""
    var Subtitle1 = ""
    var Location1 = ""
    var Lati = 0.0
    var Longi = 0.0
    
    //MARK:- Outlets --
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblSubTitle1: UILabel!
    @IBOutlet weak var lblLocation1: UILabel!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var btnMap: UIBarButtonItem!
    
    //MARK:- View LifeCycle --
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView1.image = Image1
        lblTitle1.text = Title1
        lblSubTitle1.text = Subtitle1
        lblLocation1.text = Location1
        
        imageView1.layer.cornerRadius = 10
        MapView.layer.cornerRadius = 10
        
        // For MapView
        MapView.delegate = self
        let center = CLLocationCoordinate2D(latitude: Lati, longitude: Longi)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        self.MapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = Lati
            annotation.coordinate.longitude = Longi
        MapView.addAnnotation(annotation)
        
    }

    //MARK:- Action Methods --
    
    @IBAction func MapButtonSelected(_ sender: Any) {
        
        let Location1 = CLLocationCoordinate2D(latitude: Lati, longitude: Longi)
        let Destination = MKMapItem(placemark: MKPlacemark(coordinate: Location1))
            Destination.name = "Destination"
        MKMapItem.openMaps(with: [Destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault])
        
    }
}

//MARK:- Delegate Methods --

extension ResultViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           if (annotation is MKUserLocation){
               return nil
           }else{
               let annotation1 = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationID")
                   annotation1.image = UIImage(named: "marker")
                   annotation1.frame.size = CGSize(width: 50, height: 50)
                   annotation1.centerOffset = CGPoint(x: 0, y: -25)
           
               return annotation1
           }
       }
    
}
