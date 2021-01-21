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
    
//    var dataHorizontalCollection: BehaviorRelay<[SectionModelH]> { get set }
//    var dataVerticalCollection: BehaviorRelay<[SectionModelV]> { get set }
//    var sections: Observable<[SectionModel]> { get set }
//    var dataSourceH: RxCollectionViewSectionedReloadDataSource<SectionModelH>? { get set }
//    var dataSourceV: RxCollectionViewSectionedReloadDataSource<SectionModelV>? { get set }
    var data: BehaviorRelay<WeatherData> { get set }
    func updateLocation(lat: String, lon: String)
}

//enum CellModel {
//    case horizontol(Hourly)
//  case vertical(Daily)
//}

class MainViewModel: MainViewModelProtocol {
   
    var data: BehaviorRelay<WeatherData>
//    var dataHorizontalCollection: BehaviorRelay<[SectionModelH]>
//    var dataVerticalCollection: BehaviorRelay<[SectionModelV]>
    var netWorkService: NetWorkServiceProtocol
    var router: RouterProtocol
    var lat: BehaviorRelay<String>
    var lon: BehaviorRelay<String>
//    var sections: Observable<[SectionModel]>
 //   var dataSourceH: RxCollectionViewSectionedReloadDataSource<SectionModelH>?
 //   var dataSourceV: RxCollectionViewSectionedReloadDataSource<SectionModelV>?
    var disposBag: DisposeBag
    
    required init (router: RouterProtocol, netWorkService: NetWorkServiceProtocol) {
        self.netWorkService = netWorkService
        self.router = router
        self.data = BehaviorRelay(value: WeatherData(lat: nil, lon: nil, timezone: nil, timezone_offset: nil, current: nil, hourly: nil, daily: nil))
        self.lat = BehaviorRelay<String>(value: "")
        self.lon = BehaviorRelay<String>(value: "")
        self.disposBag = DisposeBag()
 
//        let sections = ([
//          SectionModel(model: "Horizontal", items: [
//            CellModel.horizontol([Hourly(dt: 1610902800, temp: 14.01, weather: [Weather(id: 800, main: "Clear", description: "ясно", icon: "01d")])])
//          ]),
//          SectionModel(model: "Vertical", items: [
//            CellModel.vertical([Daily(dt: 1610913600, temp: Temp(day: 19.18, night: 13.74), weather: [Weather(id: 800, main: "Clear", description: "ясно", icon: "01d")])])
//          ])
//        ])
        
//        self.dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(configureCell: { datasource, collectionView, indexPath, item in
//            switch datasource[indexPath] {
//            case .Hourly(let hourly):
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath) as! HorizontalCell
//                cell.tempLabel.text = hourly.temp?.description
//                return cell
//            case .Daily(let daily):
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as! VerticalCell
//                cell.dayTempLabel.text = daily.temp?.day?.description
//                return cell
//            }
//        })
        
//        _ = isValid().asObservable().subscribe(onNext: { (bool) in
//            if bool {
//                self.netWorkService.getWeather(lat: self.lat.value, lon: self.lon.value) { (data) in
//                    if let data = data {
//                    self.data.accept(data)
//                    }
//                }
//            }
//        })
        
        self.lat.subscribe(onNext: { (event) in
            self.netWorkService.getWeather(lat: self.lat.value, lon: self.lon.value) {[weak self] (data) in
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
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(self.lat.asObservable(), self.lon.asObservable()).map { lat, lon in
            return lat.count > 1 && lon.count > 1
        }.startWith(false)
    }
  
    func updateLocation(lat: String, lon: String) {
        self.lat.accept(lat)
        self.lon.accept(lon)
    }
}

extension BehaviorRelay where Element: RangeReplaceableCollection {

    func append(_ subElement: Element.Element) {
        var newValue = value
        newValue.append(subElement)
        accept(newValue)
    }

    func append(contentsOf: [Element.Element]) {
        var newValue = value
        newValue.append(contentsOf: contentsOf)
        accept(newValue)
    }

    public func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }

    public func removeAll() {
        var newValue = value
        newValue.removeAll()
        accept(newValue)
    }

}

