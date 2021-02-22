//
//  RouterMap.swift
//  EfWeather
//
//  Created by user on 11.02.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import UIKit

class RouterMap: Router {
   unowned var viewModel: MapViewModelProtocol
   init(viewModel: MapViewModelProtocol) {
      self.viewModel = viewModel
   }
   func route(
      to routeID: String,
      from context: UIViewController,
      parameters: Any?)
   {
      guard let route = MapViewController.Route(rawValue: routeID) else {
         return
      }
      switch route {
      case .rootToMain:
        // Pop to main screen:
        context.navigationController?.popToRootViewController(animated: true)
      }
   }
}
