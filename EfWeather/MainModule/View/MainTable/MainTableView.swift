//
//  MainTableView.swift
//  EfWeather
//
//  Created by user on 19.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class MainTableView: UIView {
    
    lazy var table = createTable()
      
      override func layoutSubviews() {
          super.layoutSubviews()
        
        self.table.isHidden = false
        self.backgroundColor = .clear
        self.table.backgroundColor = .clear
      }
}
