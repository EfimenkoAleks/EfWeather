//
//  MainViewController.swift
//  EfWeather
//
//  Created by user on 15.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import CoreLocation

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    var tableView: UITableView! //view
    var weatherView: CurrentWeatherView!
    var locationManager: CLLocationManager!
    let disposBag = DisposeBag()
    var arrayIdentiferTableCell: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        gSizeWidth = self.view.bounds.size.width
        self.view.backgroundColor = .systemTeal
      
        self.locationManager = CLLocationManager()
        self.createLocation()
        self.createTable()
        self.addWeatherView()
        self.bindTable()
    }
    
    private func createTable() {
        self.tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HorizTableViewCell.self, forCellReuseIdentifier:
            HorizTableViewCell.reuseId)
        tableView.register(VerticalTableViewCell.self, forCellReuseIdentifier:
        VerticalTableViewCell.reuseId)
        tableView.isScrollEnabled = false
        
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height / 10 * 4.3).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        
        self.arrayIdentiferTableCell = [HorizTableViewCell.reuseId, VerticalTableViewCell.reuseId]
    }
    
    private func addWeatherView() {
        self.weatherView = CurrentWeatherView()
        self.weatherView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(weatherView)
        weatherView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        weatherView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
      
    }
    
    // MARK: Bind Table
    func bindTable() {
        
        self.viewModel.data
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[weak self] (newItem) in
            guard let self = self else { return }
            self.tableView.reloadData()
            }).disposed(by: disposBag)
        
//        guard let dataSourceH = self.viewModel.dataSourceH else { return }
//        self.viewModel.dataHorizontalCollection.bind(to: self.table.table.rx.items(dataSource: dataSourceH))
//            .bind(to: self.tableView.table.rx.items(dataSource: dataSource))
//                  .disposed(by: disposBag)
    }
    
   

   
}
