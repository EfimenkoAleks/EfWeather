//
//  RouterSearch.swift
//  EfWeather
//
//  Created by user on 11.02.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class RouterSearch: Router {
   unowned var viewModel: SearchViewModelProtocol
   init(viewModel: SearchViewModelProtocol) {
      self.viewModel = viewModel
   }
   func route(
      to routeID: String,
      from context: UIViewController,
      parameters: Any?)
   {
      guard let route = SearchViewController.Route(rawValue: routeID) else {
         return
      }
      switch route {
      case .popToRoot:
        // Pop to main:
       context.navigationController?.popToRootViewController(animated: true)
      }
   }
}
