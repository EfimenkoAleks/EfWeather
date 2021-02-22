//
//  Router.swift
//  EfWeather
//
//  Created by user on 15.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

protocol Router: class {
   func route(
      to routeID: String,
      from context: UIViewController,
      parameters: Any?
   )
}
