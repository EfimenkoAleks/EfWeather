//
//  Router.swift
//  EfWeather
//
//  Created by user on 15.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import MapKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemlyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showMap(coordinate: CLLocationCoordinate2D, router: RouterProtocol)
    func popToRoot()
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblyBuilder: AssemlyBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemlyBuilderProtocol){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainController = assemblyBuilder?.createMainController(router: self) else {return}
            navigationController.viewControllers = [mainController]
        }
    }
    
    func showMap(coordinate: CLLocationCoordinate2D, router: RouterProtocol) {
        if let navigationController = navigationController {
            guard let mapViewController = assemblyBuilder?.createMapController(coordinate: coordinate, router: router) else { return }
            navigationController.pushViewController(mapViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    

}

