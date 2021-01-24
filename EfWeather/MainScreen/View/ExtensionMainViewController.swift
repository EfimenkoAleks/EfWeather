//
//  ExtensionMainViewController.swift
//  EfWeather
//
//  Created by user on 19.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayIdentiferTableCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.arrayIdentiferTableCell[indexPath.row] {
        case "HorizTableViewCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: HorizTableViewCell.reuseId, for: indexPath)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: VerticalTableViewCell.reuseId, for: indexPath)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.arrayIdentiferTableCell[indexPath.row] {
        case "HorizTableViewCell":
            return gSizeHeight / 4.6
        default:
            return gSizeHeight / 2.5
        }
    }
}
