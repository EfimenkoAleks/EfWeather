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
    var tableView: MainTableView! //view
    var weatherView: CurrentWeatherView!
//    var locationManager: CLLocationManager!
    let disposBag = DisposeBag()
    var arrayIdentiferTableCell: [String]!
    var tableTopHewghtAnchor: NSLayoutConstraint?
    var citylabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createGSize()
        self.createBarItem()
        self.view.backgroundColor = .white
//        self.locationManager = CLLocationManager()
 //       self.startLocarion()
        self.addWeatherView()
        self.createTable()
        self.bindTable()
    }
 // обработка поворота экрана
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        print("Did rotate \(self.view.bounds.size.width)")
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            self.changeHeightView(height: gSizeHeight / 20)
            gSizeWidthCell = gSizeHeight
            tableView.layoutIfNeeded()
        } else {
            print("Portrait")
            self.changeHeightView(height: gSizeHeight / 10 * 4.3)
            gSizeWidthCell = gSizeWidth
            tableView.layoutIfNeeded()
            
        }
    }
// определение начальных размеров экрана
    private func createGSize() {
        gSizeWidth = self.view.bounds.size.width
        gSizeHeight = self.view.bounds.size.height
        if gSizeWidth > gSizeHeight {
            gSizeWidth = self.view.bounds.size.height
            gSizeHeight = self.view.bounds.size.width
        }
        gSizeWidthCell = gSizeWidth
    }
// анимация для таблицы при повороте
    private func changeHeightView(height: CGFloat) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.tableTopHewghtAnchor?.constant = height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
// создание таблицы
    private func createTable() {
        self.tableView = MainTableView()
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableTopHewghtAnchor = tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: gSizeHeight / 10 * 4.3)
        tableTopHewghtAnchor?.isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.table.delegate = self
        tableView.table.dataSource = self
        
 // создание масива для идентификации ячеек
        self.arrayIdentiferTableCell = [HorizTableViewCell.reuseId, VerticalTableViewCell.reuseId]
        
  // задание начальных размеров для констреинта таблицы
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            self.changeHeightView(height: gSizeHeight / 20)
            gSizeWidthCell = gSizeHeight
            tableView.layoutIfNeeded()
        }
    }
// создание view текущей погоды
    private func addWeatherView() {
        self.weatherView = CurrentWeatherView()
        self.weatherView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(weatherView)
        weatherView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        weatherView.heightAnchor.constraint(equalToConstant: gSizeHeight / 10 * 5).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        //        weatherView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        
    }
    
//    func startLocarion() {
//        LocationManager.shared.start {[weak self] (info) in
//            guard let self = self else { return }
//            guard let lat = info.latitude else { return }
//            guard let lon = info.longitude else { return }
//            self.viewModel.updateLocation(lat: lat.description, lon: lon.description)
//            self.viewModel.updateLocation(lat: "37.3317", lon: "79.0302")
//        }
//    }
    
    // MARK: Bind Table
    func bindTable() {
        
        self.viewModel.data
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (newItem) in
                guard let self = self else { return }
                self.tableView.table.reloadData()
            }).disposed(by: disposBag)
        
        self.viewModel.data
            .observeOn(MainScheduler.instance)
            .bind {[weak self] (data) in
                guard let self = self else { return }
                guard let dt = data.current?.dt else { return }
                self.weatherView.dayLabel.text = Helper.shared.dateForCurentWeather(timeDate: dt)
                guard let tempDay = data.current?.temp else { return }
                self.weatherView.tempDayLabel.text = Helper.shared.convertTemp(temp: tempDay)
                guard let tempNight = data.daily?.first?.temp?.night else { return }
                self.weatherView.tempNightLabel.text = Helper.shared.convertTemp(temp: tempNight)
                guard let humidity = data.current?.humidity else { return }
                self.weatherView.humidityLabel.text = humidity.description + "%"
                guard let wind = data.current?.wind_speed else { return }
                self.weatherView.windLabel.text = Int(wind).description + "м/сек"
                guard let image = data.current?.weather?.first?.icon else { return }
                print("\(image)")
                //               self.weatherView.weatherImageView.image = UIImage(named: "01d")
                if Helper.shared.weatherIcon.contains(image) {
                    self.weatherView.weatherImageView.image = UIImage(named:image)
                } else {
                    self.weatherView.weatherImageView.image = UIImage(named:"02d")
                }
        }.disposed(by: disposBag)
        
        self.viewModel.city
            .asDriver()
            .drive(onNext: {[weak self] (value) in
                guard let self = self else { return }
                self.citylabel?.text = value
            }).disposed(by: disposBag)
    }
// создание barButtonItem
    func createBarItem() {
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let imageMenu = UIImage(named: "ic_my_location")
        let imageTemp = imageMenu!.withRenderingMode(.alwaysTemplate)
        let map = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(MainViewController.showMap))
        map.tintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        
        let imageFavorites = UIImage(named: "ic_place")
        let imageTemplate2 = imageFavorites?.withRenderingMode(.alwaysTemplate)
        let place = UIBarButtonItem(image: imageTemplate2, style: .plain, target: self, action: #selector(MainViewController.showSearch))
        place.tintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        
        self.citylabel = UILabel(frame: CGRect(x: 3, y: 5, width: 80, height: 30))
        citylabel?.font = UIFont(name: "AvenirNext-Medium ", size: 24)
        citylabel?.text = "Запорожье"
        citylabel?.textAlignment = .left
        citylabel?.textColor = .white
        citylabel?.backgroundColor = .clear
        let barButton = UIBarButtonItem(customView: citylabel!)
        
        navigationItem.rightBarButtonItem = map
        navigationItem.leftBarButtonItems = [place, barButton]
    }
// переходы на другой контроллер
// MARK: Transition to another controller
    @objc func showMap() {
        self.viewModel.showMap()
    }
    
    @objc func showSearch() {
        self.viewModel.showSearch()
    }
    
}
