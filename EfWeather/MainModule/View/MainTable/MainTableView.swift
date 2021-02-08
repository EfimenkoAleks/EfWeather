//
//  MainTableView.swift
//  EfWeather
//
//  Created by user on 19.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    lazy var collection = createcollection()
    lazy var table = createTable()
    var curHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(height: CGFloat) {
        self.init()
        self.curHeight = height
        self.backgroundColor = .white
        self.table.backgroundColor = .clear
        self.collection.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#5A9FF0")
    }
}
