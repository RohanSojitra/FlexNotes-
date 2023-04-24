//
//  MapViewController.swift
//  FlexNotes
//
//  Created by Anil on 06/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

//MARK:- Protocol -- 
protocol HandleMapSearch {
    func DropPinZoomIn(placemark : MKPlacemark)
}

class MapViewController: UIViewController {
    
    //MARK:- Variable Declarations --
    
    var HandleLocationDelegate : HandleLocation? = nil
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var coordinates : CLLocationCoordinate2D? = nil
    var resultSearchController:UISearchController? = nil
    var selectedPin :MKPlacemark? = nil
    var addressString : String = ""
    var Latitude : Double = 0.0
    var Longitude : Double = 0.0
    
    //MARK:- Outlets --
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    //MARK:- View LifeCycle --
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        
        // For Tap Recognization on Screen
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        
        // For Location Search
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableVC") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let SearchBar = resultSearchController!.searchBar
            SearchBar.sizeToFit()
            SearchBar.placeholder = "Search for Place"
        navigationItem.searchController = resultSearchController
        resultSearchController?.hidesNavigationBarDuringPresentation = true
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.HandleMapSearchDelegate = self

    }
    
    //MARK:- Functions --
    
    @objc func handleTap(_ gestureReconizer: UITapGestureRecognizer){
        let location = gestureReconizer.location(in: mapView)
        let locationCoordinate = mapView.convert(location,toCoordinateFrom: mapView)
       
        // Add Annotation
        mapView.removeAnnotations(mapView.annotations)
        annotation.coordinate = locationCoordinate
        self.mapView.addAnnotation(annotation)
        self.addressString = ""
        // convert Coordinates into Address
        let geoCoder = CLGeocoder()
        let location1 = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            Latitude = annotation.coordinate.latitude
            Longitude = annotation.coordinate.longitude
            geoCoder.reverseGeocodeLocation(location1, completionHandler:
                { (placemarks, error) in
                    if (error != nil)
                      {
                          print("reverse geodcode fail: \(error!.localizedDescription)")
                      }
                      let pm = placemarks! as [CLPlacemark]
                    
                      if pm.count > 0 {
                          let pm = placemarks![0]
                        //var addressString : String = ""
                          if pm.subLocality != nil {
                            self.addressString = self.addressString + pm.subLocality! + " , "
                          }
                          if pm.locality != nil {
                            self.addressString = self.addressString + pm.locality! + " , "
                          }
                          if pm.country != nil {
                            self.addressString = self.addressString + pm.country!
                          }
                        print("Selected Address : \(self.addressString)")
                    }
            })
                
        return
    }
    
    //MARK:- Action Methods --
    
   @IBAction func SaveButtonClicked(_ sender: Any) {
    
    self.HandleLocationDelegate?.Location(Loc: addressString , lat : Latitude, long: Longitude)
    
        self.navigationController?.popViewController(animated: true)
    
    }
}

//MARK:- Delegate Methods --

extension MapViewController : HandleMapSearch, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate{
    
    func DropPinZoomIn(placemark: MKPlacemark) {
        addressString = ""
        Latitude = 0.0
        Longitude = 0.0
        selectedPin = placemark
        addressString = selectedPin?.title ?? ""
        Latitude = (selectedPin?.coordinate.latitude)!
        Longitude = (selectedPin?.coordinate.longitude)!
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
            annotation.coordinate = placemark.coordinate
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
            mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.04,longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
            mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // For Update Location
        if let location = locations.first{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            self.mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            print("Permission granted to use app when in use")
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            print("Permission granted to use app when in use")
            locationManager.startUpdatingLocation()
            break
        case .restricted:
            break
        case .denied:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : \(error)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation){
            return nil 
        }else{
            let annotation1 = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationIdentifier")
                annotation1.canShowCallout = false
                annotation1.image = UIImage(named: "marker")
                annotation1.frame.size = CGSize(width: 50, height: 50)
                annotation1.centerOffset = CGPoint(x: 0, y: -25)
            
            return annotation1
        }
    }
}
