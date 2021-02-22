//
//  SerchViewModel.swift
//  EfWeather
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import MapKit

protocol SearchViewModelProtocol: class {
    var city: Observable<[City]> { get }
}

class SearchViewModel: SearchViewModelProtocol {
   
//    var router: RouterProtocol
    var city: Observable<[City]>
    let disposBag = DisposeBag()

    required init () {
        
//        self.router = router
        let _city = BehaviorRelay<[City]>(value: [])
        self.city = _city.asObservable()
        
        // парсим данные из JSON
        DispatchQueue.global().async {
            Observable.just(self.loadJson())
                .observeOn(SerialDispatchQueueScheduler(qos: .background))
                .subscribe(onNext: { (city) in
                    guard let arrayCity = city else { return }
                    _city.accept(arrayCity)
                }).disposed(by: self.disposBag)
        }
    }
    
    func loadJson() -> [City]? {
        
      let decoder = JSONDecoder()
      guard
           let url = Bundle.main.url(forResource: "city", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let city = try? decoder.decode([City].self, from: data)
      else {
           return nil
      }
      return city
    }
}
