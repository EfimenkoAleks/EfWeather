//
//  MainViewModel.swift
//  EfWeather
//
//  Created by user on 15.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
import MapKit

protocol MainViewModelProtocol {
    var data: BehaviorRelay<WeatherData> { get set }
    var city: BehaviorRelay<String> { get set }
    func updateLocation(lat: String, lon: String)
    func findCity(_ str: String) -> String
    func showMap()
    func showSearch() 
}

class MainViewModel: MainViewModelProtocol {
   
    var data: BehaviorRelay<WeatherData>
    var netWorkService: NetWorkServiceProtocol
    var router: RouterProtocol
    var lat: BehaviorRelay<String>
    var lon: BehaviorRelay<String>
    var city: BehaviorRelay<String>
    var cityFromCoord: BehaviorRelay<String>
    var disposBag: DisposeBag
    
    required init (router: RouterProtocol, netWorkService: NetWorkServiceProtocol) {
        self.netWorkService = netWorkService
        self.router = router
        self.data = BehaviorRelay(value: WeatherData(lat: nil, lon: nil, timezone: nil, timezone_offset: nil, current: nil, hourly: nil, daily: nil))
        self.lat = BehaviorRelay<String>(value: "")
        self.lon = BehaviorRelay<String>(value: "")
        self.city = BehaviorRelay<String>(value: "")
        self.cityFromCoord = BehaviorRelay<String>(value: "")
        self.disposBag = DisposeBag()
        
  // следим за изменением lat и lon
        Observable.combineLatest(self.lat.asObservable(), self.lon.asObservable()).subscribe(onNext: {[weak self] (lat, lon) in
            guard let self = self else { return }
            self.netWorkService.getWeather(lat: lat, lon: lon) {[weak self] (data) in
                guard let self = self else { return }
                if let data = data {
                self.data.accept(data)
                }
            }
            self.netWorkService.getCityName(lat: lat, lon: lon) { (dataCity) in
                guard let name = dataCity?.name else { return }
                self.city.accept(name)
            }
        }).disposed(by: disposBag)
        
// подготавливаем данные для ячеек
        self.data.subscribe(onNext: { (data) in
            if data.hourly != nil {
                Helper.shared.dataHorizontalCollectionHelper.accept([SectionModelH(header: data.timezone, items: data.hourly!)])
            }
            if data.daily != nil {
                Helper.shared.dataVerticalCollectionHelper.accept([SectionModelV(header: data.timezone, items: data.daily!)])
            }
            }).disposed(by: disposBag)
      
 // координаты из карты для main и перезагрузка данных
        Helper.shared.coordinateForMian.subscribe(onNext: {[weak self] (event) in
            guard let self = self else { return }
            self.updateLocation(lat: event.latitude.description, lon: event.longitude.description)
        }).disposed(by: disposBag)
        
        self.startLocation()
    }
    
    func startLocation() {
        LocationManager.shared.start {[weak self] (info) in
            guard let self = self else { return }
            guard let lat = info.latitude else { return }
            guard let lon = info.longitude else { return }
            self.updateLocation(lat: lat.description, lon: lon.description)
        }
// для запуска на симуляторе , при билде для телефона закоментировать
        self.updateLocation(lat: "47.84108145851735", lon: "35.14000413966346")
    }
   
    func findCity(_ str: String) -> String {
        var mySource = ""
        var separated = false
        for iChar in str {
            if iChar == "/" {
                separated = true
                continue
            }
            if separated {
               mySource += String(iChar)
            }
        }
        return mySource
    }
  
    func updateLocation(lat: String, lon: String) {
        self.lat.accept(lat)
        self.lon.accept(lon)
    }
// переход на мап контроллер
    func showMap() {
  
        if self.lat.value.count > 1 && self.lon.value.count > 1 {
        let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: Double(self.lat.value)!)!, longitude: CLLocationDegrees(exactly: Double(self.lon.value)!)!)
            self.router.showMap(coordinate: coord, router: self.router)
        }
    }
    
    func showSearch() {
        self.router.showSearch(router: self.router)
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)}

}

