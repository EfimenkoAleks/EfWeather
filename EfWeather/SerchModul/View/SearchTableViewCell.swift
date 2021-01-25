//
//  SearchTableViewCell.swift
//  EfWeather
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static var reuseId: String = "SearchCell"
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 34)
        lb.textAlignment = .left
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


