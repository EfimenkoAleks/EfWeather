//
//  RouterMain.swift
//  EfWeather
//
//  Created by user on 11.02.2021.
//  Copyright © 2021 user. All rights reserved.
//
import UIKit
import CoreLocation

class RouterMain: Router {
   unowned var viewModel: MainViewModelProtocol
   init(viewModel: MainViewModelProtocol) {
      self.viewModel = viewModel
   }
   func route(
      to routeID: String,
      from context: UIViewController,
      parameters: Any?)
   {
      guard let route = MainViewController.Route(rawValue: routeID) else {
         return
      }
      switch route {
      case .map:
        // Push map screen:
        let vc = MapViewController()
        let vm = MapViewModel(coordinate: parameters as! CLLocationCoordinate2D)
        vc.viewModel = vm
        vc.router = RouterMap(viewModel: vm)
        vc.callback = {[weak self] coord in
            guard let self = self else { return }
            self.viewModel.updateLocation(lat: coord.latitude.description, lon: coord.longitude.description)
        }
       context.navigationController?.pushViewController(vc, animated: true)
      case .search:
         // Push search screen:
         let vc = SearchViewController()
         let vm = SearchViewModel()
         vc.viewModel = vm
         vc.router = RouterSearch(viewModel: vm)
        vc.callback = {[weak self] coord in
            guard let self = self else { return }
            self.viewModel.updateLocation(lat: coord.latitude.description, lon: coord.longitude.description)
        }
        context.navigationController?.pushViewController(vc, animated: true)
      }
   }
}

