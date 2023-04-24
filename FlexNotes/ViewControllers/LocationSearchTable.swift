//
//  LocationSearchTableViewController.swift
//  FlexNotes
//
//  Created by Anil on 07/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {

    //MARK:- Var Declarations --
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var HandleMapSearchDelegate: HandleMapSearch? = nil
    
    //MARK:- View LifeCycle --
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - TableView Datasource --

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedItem = matchingItems[indexPath.row].placemark
            cell.textLabel?.text = selectedItem.name
        let address = "\(selectedItem.locality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.country ?? "")"
            cell.detailTextLabel?.text = address
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        HandleMapSearchDelegate?.DropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
        
        print("Selected Search Address : \(selectedItem.title!)")
    }

}

//MARK:- Delegate Methods --

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
        let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchBarText
            request.region = mapView.region
        let search = MKLocalSearch(request: request)
            search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
