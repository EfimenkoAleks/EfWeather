//
//  ExtensionSearchConrtoller.swift
//  EfWeather
//
//  Created by user on 26.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        self.filtredArray = self.arrayCity!.value.filter({$0.name!.contains(searchText)})
        self.tableView.table.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.filtredArray!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.table.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseId, for: indexPath) as! SearchTableViewCell

        if isFiltering {
            cell.nameLabel.text = self.filtredArray?[indexPath.row].name
        } else {
            cell.nameLabel.text = self.arrayCity?.value[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = self.tableView.table.cellForRow(at: indexPath) as! SearchTableViewCell

     if isFiltering {
        let city = self.filtredArray?[indexPath.row]
        cell.nameLabel.text = city?.name
        let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: (city?.coord?.lat)!)!, longitude: CLLocationDegrees(exactly: (city?.coord?.lon)!)!)
        callback?(coord)
     }
     
        self.router.route(to: Route.popToRoot.rawValue, from: self, parameters: nil)
    }
}
