//
//  MapViewModel.swift
//  EfWeather
//
//  Created by user on 24.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import MapKit

protocol MapViewModelProtocol: class {
    var coordinate: CLLocationCoordinate2D { get set }
    var user: Observable<User> { get }
}

class MapViewModel: MapViewModelProtocol {
   
//    var router: RouterProtocol
    var coordinate: CLLocationCoordinate2D
    var user: Observable<User>

    required init (coordinate: CLLocationCoordinate2D) {
       
//        self.router = router
        self.coordinate = coordinate
        let _user = BehaviorRelay<User>(value: User(name: "You", coordinate: self.coordinate))
        self.user = _user.asObservable()
    }
}
