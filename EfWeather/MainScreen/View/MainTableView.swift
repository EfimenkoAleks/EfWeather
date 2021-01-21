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
          self.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
          self.table.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
      }
}
