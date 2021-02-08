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
    var data: Observable<WeatherData> { get }
    var city: Observable<String> { get }
    var daily: Observable<[SectionModelV]> { get }
    var hourly: Observable<[SectionModelH]> { get }
    var getLocation: GetLocation { get }
    func showMap()
    func showSearch() 
}

class MainViewModel: MainViewModelProtocol {
    
    var data: Observable<WeatherData>
    var netWorkService: NetWorkServiceProtocol
    var router: RouterProtocol
    var lat: BehaviorRelay<String>
    var lon: BehaviorRelay<String>
    var city: Observable<String>
    var cityFromCoord: BehaviorRelay<String>
    var daily: Observable<[SectionModelV]>
    var hourly: Observable<[SectionModelH]>
    var disposBag: DisposeBag
    var getLocation: GetLocation
    
    required init (router: RouterProtocol, netWorkService: NetWorkServiceProtocol) {
        self.netWorkService = netWorkService
        self.router = router
        let _data = BehaviorRelay(value: WeatherData.empty)
        self.data = _data.asObservable()
        self.lat = BehaviorRelay<String>(value: "")
        self.lon = BehaviorRelay<String>(value: "")
        let _city = BehaviorRelay<String>(value: "")
        self.city = _city.asObservable()
        self.cityFromCoord = BehaviorRelay<String>(value: "")
        
        let _daily = BehaviorRelay<[Daily]>(value: [Daily(dt: nil, sunrise: nil, sunset: nil, temp: nil, feels_like: nil, pressure: nil, humidity: nil, dew_point: nil, wind_speed: nil, wind_deg: nil, weather: nil, clouds: nil, pop: nil, rain: nil, uvi: nil)])
        self.daily = _daily.asObservable()
            .map({ (daily) -> [SectionModelV] in
                let arrayList = [SectionModelV(header: "Daily", items: daily)]
                return arrayList
        })
        
        let _hourlyVM = BehaviorRelay<[Hourly]>(value: [Hourly(dt: nil, temp: nil, feels_like: nil, pressure: nil, humidity: nil, dew_point: nil, uvi: nil, clouds: nil, visibility: nil, wind_speed: nil, wind_deg: nil, weather: nil, pop: nil)])
        self.hourly = _hourlyVM.asObservable()
            .map({ (hourly) -> [SectionModelH] in
                let arrayList = [SectionModelH(header: "Daily", items: hourly)]
                return arrayList
            })
        
        self.disposBag = DisposeBag()
        self.getLocation = GetLocation()
 
 // запускаем определение локейшен
        self.getLocation.run { [weak self] (location) in
            guard let self = self else { return }
            if let location = location {
                self.updateLocation(lat: location.coordinate.latitude.description, lon: location.coordinate.longitude.description)
            } else {
                print("Get Location failed \(String(describing: self.getLocation.failWithError))")
 // для использования на симуляторе разкоментировать
                self.updateLocation(lat: "47.84108145851735", lon: "35.14000413966346")
            }
        }
        
// следим за изменением lat и lon
        Observable.combineLatest(self.lat.asObservable(), self.lon.asObservable())
            .subscribe(onNext: {[weak self] (lat, lon) in
                guard let self = self else { return }
                self.netWorkService.getWeather(lat: lat, lon: lon) { (data) in
                    if let data = data {
                        _data.accept(data)
                    }
                }
                self.netWorkService.getCityName(lat: lat, lon: lon) { (dataCity) in
                    guard let name = dataCity?.name else { return }
                    _city.accept(name)
                }
            }).disposed(by: self.disposBag)
        
// подготавливаем данные для ячеек
        self.data.subscribe(onNext: { (data) in
            guard let dataHourly = data.hourly else { return }
            _hourlyVM.accept(dataHourly)
            
            guard let dataDaily = data.daily else { return }
            _daily.accept(dataDaily)
        }).disposed(by: self.disposBag)
        
// координаты из карты для main и перезагрузка данных
        Helper.shared.coordinateForMian.subscribe(onNext: {[weak self] (event) in
            guard let self = self else { return }
            self.updateLocation(lat: event.latitude.description, lon: event.longitude.description)
        }).disposed(by: self.disposBag)
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
    
}

