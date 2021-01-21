//
//  ExtensionMainTableView.swift
//  EfWeather
//
//  Created by user on 19.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

extension MainTableView {
    
    func createTable() -> UITableView {
        let tableView = UITableView()
        
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HorizTableViewCell.self, forCellReuseIdentifier: HorizTableViewCell.reuseId)
        tableView.register(VerticalTableViewCell.self, forCellReuseIdentifier: VerticalTableViewCell.reuseId)
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        return tableView
    }
}

