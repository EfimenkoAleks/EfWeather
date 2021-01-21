//
//  AssemlyBilder.swift
//  EfWeather
//
//  Created by user on 15.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

protocol AssemlyBuilderProtocol {
    func createMainController(router: RouterProtocol) -> UIViewController
}

class AssemlyBilder: AssemlyBuilderProtocol {
    func createMainController(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetWorkService()
        let viewModel = MainViewModel(router: router, netWorkService: networkService)
        view.viewModel = viewModel
        return view
    }
    

}

