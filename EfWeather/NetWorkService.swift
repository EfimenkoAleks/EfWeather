//
//  NetWorkService.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation

protocol NetWorkServiceProtocol {
    func getWeather(lat: String, lon: String, completion: @escaping (WeatherData?) -> Void)
    func getCityName(lat: String, lon: String, completion: @escaping (WeatherCity?) -> Void)
}

class NetWorkService: NetWorkServiceProtocol {
    
    func getWeather(lat: String, lon: String, completion: @escaping (WeatherData?) -> Void) {

         let curentlat = "lat=" + lat + "&"
        let curentlon = "lon=" + lon + "&"
 let requestStr = "https://api.openweathermap.org/data/2.5/onecall?" + curentlat + curentlon + "exclude=minutely&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab"
        
         let request = NSMutableURLRequest(url: NSURL(string: requestStr)! as URL,
                                           cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
         request.httpMethod = "GET"
         
         let session = URLSession.shared
         let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
             if (error != nil) {
                 print(error ?? "error")
             } else {
                guard let dataRez = data else { return }
                let parsedResult: WeatherData = try! JSONDecoder().decode(WeatherData.self, from: dataRez)
                print("\(parsedResult)")
                 completion(parsedResult)
             }
         })
         
         dataTask.resume()
    }
 // запрос чтоб получить город
      func getCityName(lat: String, lon: String, completion: @escaping (WeatherCity?) -> Void) {

            let curentlat = "lat=" + lat + "&"
           let curentlon = "lon=" + lon + "&"
    let requestStr = "https://api.openweathermap.org/data/2.5/weather?" + curentlat + curentlon + "&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab"
        
//        https://api.openweathermap.org/data/2.5/weather?lat=47.84108145851735&lon=35.14000413966346&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab
        
// https://api.openweathermap.org/data/2.5/onecall?lat=47.84108145851735&lon=35.14000413966346&exclude=minutely&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab
           
            let request = NSMutableURLRequest(url: NSURL(string: requestStr)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
                if (error != nil) {
                    print(error ?? "error")
                } else {
                   guard let dataRez = data else { return }
                   let parsedResult: WeatherCity = try! JSONDecoder().decode(WeatherCity.self, from: dataRez)
                   print("\(parsedResult)")
                    completion(parsedResult)
                }
            })
            
            dataTask.resume()
       }
}
