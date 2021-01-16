//
//  Router.swift
//  EfWeather
//
//  Created by user on 15.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemlyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
//    func initialViewController()
//    func showListNews(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int)
//    func showWebNews(newStr: SqlNewsModel)
//    func showDetail(comment: Comment?)
//    func showLeague(country: String)
//    func popToRoot()
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
        }
    }

}

