//
//  Helper.swift
//  EfWeather
//
//  Created by user on 20.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class Helper {
    
   static let shared = Helper()
    
    var dataHorizontalCollectionHelper = BehaviorRelay<[SectionModelH]>(value: [])
    var dataVerticalCollectionHelper = BehaviorRelay<[SectionModelV]>(value: [])

}

var gSizeWidth: CGFloat = 0

