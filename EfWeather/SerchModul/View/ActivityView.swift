//
//  ActivityView.swift
//  EfWeather
//
//  Created by user on 30.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class ActivityView: UIView {
    lazy var activityView = self.createActivityView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.5)
        self.activityView.tintColor = .white
    }
    
    func startIndicator() {
        self.activityView.startAnimating()
    }
    
    func stopIndicator() {
        if self.activityView.isAnimating {
           self.activityView.stopAnimating()
        }
    }
}

extension ActivityView {
    
    func createActivityView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        return activityIndicator
    }
}
