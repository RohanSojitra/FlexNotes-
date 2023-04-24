//
//  ViewTableViewCell.swift
//  FlexNotes
//
//  Created by Anil on 11/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

/*import UIKit
import MapKit
import CoreLocation

class ViewTableViewCell: UITableViewCell, MKMapViewDelegate{

    //MARK:- Variable Declaration --
    
    var listNotes : [Notes]? = nil
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var coordinates : CLLocationCoordinate2D? = nil;
    
    //MARK:- Outlets --
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblSubTitle1: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var mapView1: MKMapView!
    
    //MARK:- View LifeCycle --

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let mapView = self.mapView1{
            mapView.delegate = self
        }
        
        imageView1.layer.cornerRadius = 10
        // Set Center for Mapview
        let center = CLLocationCoordinate2D(latitude: 23.035007, longitude: 72.529327)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        self.mapView1.setRegion(region, animated: true)
        
    }

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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
*/
