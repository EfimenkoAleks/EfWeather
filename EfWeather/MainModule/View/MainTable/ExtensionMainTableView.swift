//
//  ExtensionMainTableView.swift
//  EfWeather
//
//  Created by user on 19.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

extension MainView {
    
    func createTable() -> UITableView {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VerticalCell.self, forCellReuseIdentifier: VerticalCell.reuseId)
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.collection.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        return tableView
    }
}

extension MainView {
    
    func createcollection() -> UICollectionView {
        var collectionView: UICollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 85, height: curHeight / 7.5)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: HorizontalCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#5A9FF0")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: self.curHeight / 4.7).isActive = true
        
        return collectionView
    }
}

