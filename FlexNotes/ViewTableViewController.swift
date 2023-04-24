//
//  ViewTableViewController.swift
//  FlexNotes
//
//  Created by Anil on 11/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//
/*
import UIKit
import CoreData
import MapKit

class ViewTableViewController: UITableViewController {

    //MARK:- Var Declaration --
    
    var listNotes : [Notes]? = nil
    var handler = CoreDataHandler()
    var coordinates : CLLocationCoordinate2D? = nil
    var controller = CoreTableViewController()
    
    var Image1 = UIImage()
    var Title1 = ""
    var Subtitle1 = ""
    var Location1 = ""
    
    //MARK:- View LifeCycle --
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listNotes = handler.getData()
        listNotes?.reverse()
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listNotes!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ViewTableViewCell
        
       
        
        cell.imageView1.image = Image1
        cell.lblTitle1.text = Title1
        cell.lblSubTitle1.text = Subtitle1
        cell.lblLocation.text = self.listNotes![indexPath.row].location ?? ""
        
        
        /* let str = self.listNotes![indexPath.row].image ?? ""
        if str != "" {
            cell.imageView1.image = convertBase64StringToImage(imageBase64String: str)
        }
        cell.lblTitle1.text = self.listNotes![indexPath.row].title ?? ""
        cell.lblSubTitle1.text = self.listNotes![indexPath.row].subtitle ?? ""
        cell.lblLocation.text = self.listNotes![indexPath.row].location ?? ""
        */
 
            // For Mapview in Cell
            let Lati = self.listNotes![indexPath.row].latitude
            let Longi = self.listNotes![indexPath.row].longitude
            
            cell.mapView1.centerCoordinate.latitude = Lati
            cell.mapView1.centerCoordinate.longitude = Longi
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = Lati
            annotation.coordinate.longitude = Longi
            cell.mapView1.addAnnotation(annotation)
        
        return cell
    }

}
*/
