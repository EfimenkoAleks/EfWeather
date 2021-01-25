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

protocol SearchViewModelProtocol {
    var city: BehaviorRelay<[City]> {get set}
    func toRootViewController()
}

class SearchViewModel: SearchViewModelProtocol {
   
    var router: RouterProtocol
    var city: BehaviorRelay<[City]>
    let disposBag = DisposeBag()

    required init (router: RouterProtocol) {
       
        self.router = router
        self.city = BehaviorRelay(value: [])
        
 // парсим данные из JSON
        Observable.just(self.loadJson()).subscribe(onNext: {[weak self] (city) in
            guard let self = self else { return }
            guard let arrayCity = city else { return }
            self.city.accept(arrayCity)
            print("self.city.accept(arrayCity)")
        }).disposed(by: self.disposBag)
        
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
    
// переход на первый контроллер
    func toRootViewController() {
        self.router.popToRoot()
    }
}
