//
//  User.swift
//  EfWeather
//
//  Created by user on 24.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import MapKit

class User: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var title: String? {
        return name
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.name = name
    }
}
