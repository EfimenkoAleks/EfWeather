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

protocol MapViewModelProtocol {
    var coordinate: CLLocationCoordinate2D { get set }
    var user: BehaviorRelay<User> { get set }
    func toRootViewController()
}

class MapViewModel: MapViewModelProtocol {
   
    var router: RouterProtocol
    var coordinate: CLLocationCoordinate2D
    var user: BehaviorRelay<User>

    required init (coordinate: CLLocationCoordinate2D, router: RouterProtocol) {
       
        self.router = router
        self.coordinate = coordinate
        self.user = BehaviorRelay<User>(value: User(name: "You", coordinate: self.coordinate))
    }
    
// переход на первый контроллер
    func toRootViewController() {
        self.router.popToRoot()
    }
}
