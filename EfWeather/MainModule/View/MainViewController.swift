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
    var mainView: MainView! //view
    var weatherView: CurrentWeatherView!
    let disposBag = DisposeBag()
    var tableTopHewghtAnchor: NSLayoutConstraint?
    var citylabel: UILabel?
    var curentWidth: CGFloat? // ширина устройства
    var curentHeight: CGFloat? // высота устройства
    var heightCellVertical: CGFloat? // высота устройства для вертикальной ячейки
    
    // создаём lazy dataSource
    lazy var dataSourceH: RxCollectionViewSectionedReloadDataSource<SectionModelH> = {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModelH>(configureCell: { (_, collection, indexPath, item) -> UICollectionViewCell in
            
            let cell = collection.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath) as! HorizontalCell
            
            if let temp = item.temp {
                cell.tempLabel.text = Helper.shared.convertTemp(temp: temp)
            }
            if let date = item.dt {
                cell.timeLabel.text = Helper.shared.timeForHourly(timeDate: date)
            }
            guard let weather = item.weather else { return cell}
            if let icon = weather[0].icon {
                if Helper.shared.weatherIcon.contains(icon) {
                    cell.weatherImageView.image = UIImage(named: icon)
                } else {
                    cell.weatherImageView.image = UIImage(named: "02d")
                }
            }
            return cell
        })
        return dataSource
    }()
    
    lazy var dataSourceV: RxTableViewSectionedReloadDataSource<SectionModelV> = {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModelV>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VerticalCell.reuseId, for: indexPath) as! VerticalCell
            
            if let day = item.dt {
                cell.dayLabel.text = Helper.shared.dayForVerticalCell(timeDate: day)
            }
            if let night = item.temp?.night {
                cell.nightTempLabel.text = Helper.shared.convertTemp(temp: night)
            }
            if let day = item.temp?.day {
                cell.dayTempLabel.text = Helper.shared.convertTemp(temp: day)
            }
            if let icon = item.weather?[0].icon {
                if Helper.shared.weatherIcon.contains(icon) {
                    cell.weatherImageView.image = UIImage(named: icon)
                } else {
                    cell.weatherImageView.image = UIImage(named: "02d")
                }
                cell.weatherImageView.tintColor = Helper.shared.hexStringToUIColor(hex: "#000000")
                cell.weatherImageView.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#000000")
            }
            return cell
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#4A90E2")
        if self.view.bounds.height > self.view.bounds.width {
            self.curentHeight = self.view.bounds.height
            self.curentWidth = self.view.bounds.width
            self.heightCellVertical = self.view.bounds.height
        } else {
            self.curentHeight = self.view.bounds.width
            self.curentWidth = self.view.bounds.height
            self.heightCellVertical = self.view.bounds.width
        }
        self.createBarItem()
        self.createTableAndCollection()
        self.bindTable()
    }
    
    // создание таблицы
    // MARK: Create View table and collection
    private func createTableAndCollection() {
        
        guard let height = self.curentHeight else { return }
        self.mainView = MainView(height: height)
        self.view.addSubview(self.mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        if self.view.bounds.size.width > self.view.bounds.size.height {
            tableTopHewghtAnchor = mainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.size.height / 8)
        } else {
            tableTopHewghtAnchor = mainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.size.height / 2.3)
        }
        tableTopHewghtAnchor?.isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mainView.table.delegate = self
        mainView.collection.delegate = self
        // добавляем view текущей погоды
        if self.view.bounds.width > self.view.bounds.height {
            self.addWeatherView(hiden: true)
        } else {
            self.addWeatherView(hiden: false)
        }
    }
    
    // создание view текущей погоды
    private func addWeatherView(hiden: Bool) {
        guard let height = self.curentHeight else { return }
        guard let width = self.curentWidth else { return }
        if self.weatherView == nil {
            if height > width {
                self.weatherView = CurrentWeatherView(width: width, height: height)
            } else {
                self.weatherView = CurrentWeatherView(width: height, height: width)
            }
            self.weatherView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(weatherView)
            
            weatherView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            weatherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            weatherView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            weatherView.bottomAnchor.constraint(equalTo: self.mainView.topAnchor).isActive = true
        }
        // прячем или показываем view текущей погоды
        self.weatherView.isHidden = hiden
    }
    
    // обработка поворота экрана
    //MARK: Rotate device
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            self.changeHeightView(height: size.height / 8, changed: true)
            self.curentHeight = size.height
            self.curentWidth = size.width
            self.addWeatherView(hiden: true)
            self.mainView.layoutIfNeeded()
        } else {
            print("Portrait")
            self.changeHeightView(height: size.height / 10 * 4.3, changed: false)
            self.curentHeight = size.height
            self.curentWidth = size.width
            self.addWeatherView(hiden: false)
            self.mainView.layoutIfNeeded()
        }
    }
    
    // анимация для таблицы при повороте
    private func changeHeightView(height: CGFloat, changed: Bool) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.tableTopHewghtAnchor?.constant = height
            self.weatherView.isHidden = changed
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: Bind Table
    func bindTable() {
        
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
                if Helper.shared.weatherIcon.contains(image) {
                    self.weatherView.weatherImageView.image = UIImage(named:image)
                } else {
                    self.weatherView.weatherImageView.image = UIImage(named:"02d")
                }
            }.disposed(by: disposBag)
        
        self.viewModel.city
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (value) in
                guard let self = self else { return }
                self.citylabel?.text = value
            }).disposed(by: disposBag)
        
        self.viewModel.daily
            .observeOn(MainScheduler.instance)
            .bind(to: self.mainView.table.rx.items(dataSource: self.dataSourceV))
            .disposed(by: disposBag)
        
        self.viewModel.hourly
            .observeOn(MainScheduler.instance)
            .bind(to: self.mainView.collection.rx.items(dataSource: self.dataSourceH))
            .disposed(by: disposBag)
        
        self.viewModel.failurData
            .subscribe {[weak self] (_) in
                guard let self = self else { return }
                self.failurDataAlert()
            }.disposed(by: disposBag)

    }
    
    private func failurDataAlert() {
        let title = "Something went wrong with the data"
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
       
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(OKAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // создание barButtonItem
    // MARK: Create barbuttonItem
    func createBarItem() {
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let imageMenu = UIImage(named: "ic_my_location")
        let imageTemp = imageMenu!.withRenderingMode(.alwaysTemplate)
        let map = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(MainViewController.showMap))
        map.tintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        
        let imagereload = UIImage(systemName: "arrow.clockwise")
        let imageTempRe = imagereload!.withRenderingMode(.alwaysTemplate)
        let reload = UIBarButtonItem(image: imageTempRe, style: .plain, target: self, action: #selector(MainViewController.reloadLocation))
        reload.tintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        
        let imageFavorites = UIImage(named: "ic_place")
        let imageTemplate2 = imageFavorites?.withRenderingMode(.alwaysTemplate)
        let place = UIBarButtonItem(image: imageTemplate2, style: .plain, target: self, action: #selector(MainViewController.showSearch))
        place.tintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        
        self.citylabel = UILabel(frame: CGRect(x: 3, y: 5, width: 80, height: 30))
        citylabel?.font = UIFont(name: "AvenirNext-Medium ", size: 24)
        citylabel?.text = ""
        citylabel?.textAlignment = .left
        citylabel?.textColor = .white
        citylabel?.backgroundColor = .clear
        let barButton = UIBarButtonItem(customView: citylabel!)
        
        navigationItem.rightBarButtonItems = [map, reload]
        navigationItem.leftBarButtonItems = [place, barButton]
    }
    
    @objc private func reloadLocation() {
        self.viewModel.getLocation.restartLocation()
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
