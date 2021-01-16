//
//  NetWorkService.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation

protocol NetWorkServiceProtocol {
    func getWeather(city: String, completion: @escaping(Data?) -> Void)
}

class NetWorkService: NetWorkServiceProtocol {
    
    func getWeather(city: String, completion: @escaping (Data?) -> Void) {
     
         let appid = "&appid=9235dd62d3f74c7814a8a04526e91cab"
         let q = "q=" + city + "&"
        let unit = "units=metric&"
         let lang = "&lang=ru"
 // http://api.openweathermap.org/data/2.5/weather?q=Днепр&units=metric&&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab
         let request = NSMutableURLRequest(url: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?" + q + unit + lang + appid)! as URL,
                                           cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
         request.httpMethod = "GET"
         
         let session = URLSession.shared
         let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
             if (error != nil) {
                 print(error ?? "error")
             } else {
                 completion(data)
             }
         })
         
         dataTask.resume()
    }
    
    
    
}
