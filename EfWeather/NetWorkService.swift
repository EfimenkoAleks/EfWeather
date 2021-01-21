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
}

class NetWorkService: NetWorkServiceProtocol {
    
    func getWeather(lat: String, lon: String, completion: @escaping (WeatherData?) -> Void) {
     
         let appid = "appid=9235dd62d3f74c7814a8a04526e91cab"
         let lat = lat + "&"
        let lon = lon + "&"
        let exclud = "minutely,alerts&"
        let unit = "units=metric&"
         let lang = "lang=ru&"
 
// https://api.openweathermap.org/data/2.5/onecall?lat=37.331676&lon=72.030189&exclude=minutely&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab
        
 // "https://api.openweathermap.org/data/2.5/onecall?" + lat + lon + exclud + unit + lang + appid
        
         let request = NSMutableURLRequest(url: NSURL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=37.331676&lon=72.030189&exclude=minutely&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab")! as URL,
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
    
    
    
}
