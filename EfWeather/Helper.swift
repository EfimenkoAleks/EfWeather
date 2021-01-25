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
import CoreLocation

class Helper {
    
    static let shared = Helper()
  
// переменные для передачи данных между контролерами
    var dataHorizontalCollectionHelper = BehaviorRelay<[SectionModelH]>(value: [])
    var dataVerticalCollectionHelper = BehaviorRelay<[SectionModelV]>(value: [])
    var coordinateForMian = PublishSubject<[CLLocationCoordinate2D]>()
    var cityForMain = BehaviorRelay<City?>(value: nil)
    
// масив названий icon для image cell
    let weatherIcon = ["01d", "01n", "02d", "02n", "03d", "03n", "04d", "04n", "09d", "09n", "10d", "10n", "11d", "11n", "13d", "13n", "50d", "50n"]
    
    
    func convertTemp(temp: Double) -> String {
        return "\(Int(temp))º"
    }
// получение текущей даты для главного экрана
    func dateForCurentWeather(timeDate: Double) -> String {
        let date = Date(timeIntervalSince1970: timeDate)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        let cal = Calendar(identifier: .gregorian)
        let dayOfWeek = cal.component(.weekday, from: date)
        var strDayWeak = ""
        switch dayOfWeek {
        case 1:
            strDayWeak = "ВС"
        case 2:
            strDayWeak = "ПН"
        case 3:
            strDayWeak = "ВТ"
        case 4:
            strDayWeak = "СР"
        case 5:
            strDayWeak = "ЧТ"
        case 6:
            strDayWeak = "ПТ"
        case 7:
            strDayWeak = "СБ"
        default:
            strDayWeak = "NO"
        }
        let month = cal.component(.month, from: date)
        var strMounth = ""
        switch month {
        case 1:
            strMounth = "Января"
        case 2:
            strMounth = "Февраля"
        case 3:
            strMounth = "Марта"
        case 4:
            strMounth = "Апреля"
        case 5:
            strMounth = "Мая"
        case 6:
            strMounth = "Июня"
        case 7:
            strMounth = "Июля"
        case 8:
            strMounth = "Августа"
        case 9:
            strMounth = "Сентября"
        case 10:
            strMounth = "Октября"
        case 11:
            strMounth = "Ноября"
        case 12:
            strMounth = "Декабря"
        default:
            strMounth = "NO"
        }
        
        dateFormatter.dateFormat = "dd"
        let strDay = dateFormatter.string(from: date)
        let strTime = strDayWeak + ", " + strDay + " " + strMounth
        return strTime
    }

// преобразование hex в цвет
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

// получение времени для почасового отображения
    func timeForHourly(timeDate: Double) -> String {
        let date = Date(timeIntervalSince1970: timeDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EDT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH"
        let strTime = dateFormatter.string(from: date)
        
        return strTime
    }

// получение дня недели из даты
    func dayForVerticalCell(timeDate: Double) -> String {
        let date = Date(timeIntervalSince1970: timeDate)
        let cal = Calendar(identifier: .gregorian)
        let dayOfWeek = cal.component(.weekday, from: date)
        switch dayOfWeek {
        case 1:
            return "ВС"
        case 2:
            return "ПН"
        case 3:
            return "ВТ"
        case 4:
            return "СР"
        case 5:
            return "ЧТ"
        case 6:
            return "ПТ"
        case 7:
            return "СБ"
        default:
            return "NO"
        }
    }
    
    
}

// глобальные переменные для определения размеров экрана
var gSizeWidth: CGFloat = 0
var gSizeWidthCell: CGFloat = 0
var gSizeHeight: CGFloat = 0


