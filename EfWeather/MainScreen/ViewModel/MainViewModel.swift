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

protocol MainViewModelProtocol {
    var data: BehaviorRelay<WeatherData> { get set }
    func updateLocation(lat: String, lon: String)
    func findCity(_ str: String) -> String
}

class MainViewModel: MainViewModelProtocol {
   
    var data: BehaviorRelay<WeatherData>
    var netWorkService: NetWorkServiceProtocol
    var router: RouterProtocol
    var lat: BehaviorRelay<String>
    var lon: BehaviorRelay<String>
    var disposBag: DisposeBag
    
    required init (router: RouterProtocol, netWorkService: NetWorkServiceProtocol) {
        self.netWorkService = netWorkService
        self.router = router
        self.data = BehaviorRelay(value: WeatherData(lat: nil, lon: nil, timezone: nil, timezone_offset: nil, current: nil, hourly: nil, daily: nil))
        self.lat = BehaviorRelay<String>(value: "")
        self.lon = BehaviorRelay<String>(value: "")
        self.disposBag = DisposeBag()
    
        Observable.combineLatest(self.lat.asObservable(), self.lon.asObservable()).subscribe(onNext: { (lat, lon) in
            self.netWorkService.getWeather(lat: lat, lon: lon) {[weak self] (data) in
                guard let self = self else { return }
                if let data = data {
                self.data.accept(data)
                }
            }
        }).disposed(by: disposBag)
        
        self.data.subscribe(onNext: { (data) in
            if data.hourly != nil {
                Helper.shared.dataHorizontalCollectionHelper.accept([SectionModelH(header: data.timezone, items: data.hourly!)])
            }
            if data.daily != nil {
                Helper.shared.dataVerticalCollectionHelper.accept([SectionModelV(header: data.timezone, items: data.daily!)])
            }
            }).disposed(by: disposBag)
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
}

