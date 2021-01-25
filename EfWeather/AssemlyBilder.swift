//
//  AssemlyBilder.swift
//  EfWeather
//
//  Created by user on 15.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import MapKit

protocol AssemlyBuilderProtocol {
    func createMainController(router: RouterProtocol) -> UIViewController
    func createMapController(coordinate: CLLocationCoordinate2D, router: RouterProtocol) -> UIViewController
}

class AssemlyBilder: AssemlyBuilderProtocol {
    func createMainController(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetWorkService()
        let viewModel = MainViewModel(router: router, netWorkService: networkService)
        view.viewModel = viewModel
        return view
    }
    
    func createMapController(coordinate: CLLocationCoordinate2D, router: RouterProtocol) -> UIViewController {
        let view = MapViewController()
        let viewModel = MapViewModel(coordinate: coordinate, router: router)
        view.viewModel = viewModel
        return view
    }
    
}

