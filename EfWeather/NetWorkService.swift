//
//  NetWorkService.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation

// протокол для нетворк сервиса
protocol NetWorkServiceProtocol {
    func getWeather(lat: String, lon: String, completion: @escaping (Result<WeatherData>) -> Void)
    func getCityName(lat: String, lon: String, completion: @escaping (Result<WeatherCity>) -> Void)
}
// дженерик для результата запроса
enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIError: Error {
    case noData
}
// определение ресурса для запроса
struct Resource {
    let url: URL
    let method: String = "GET"
}

class NetWorkService: NetWorkServiceProtocol {
 
// приватная функция для запроса данных
    private func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                result(.failure(APIError.noData))
                return
            }
            if let error = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
// получить погоду
    func getWeather(lat: String, lon: String, completion: @escaping (Result<WeatherData>) -> Void) {
        
        let curentlat = "lat=" + lat + "&"
        let curentlon = "lon=" + lon + "&"
        let requestStr = "https://api.openweathermap.org/data/2.5/onecall?" + curentlat + curentlon + "exclude=minutely&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab"
        
        guard let url = URL(string: requestStr) else { return }
        let resorce = Resource(url: url)
        
        self.load(resorce) { (result) in
            switch result {
            case .success(let data):
                do {
                    let parsedResult: WeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                   // print("\(parsedResult)")
                    completion(.success(parsedResult))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
// запрос чтоб получить город
    func getCityName(lat: String, lon: String, completion: @escaping (Result<WeatherCity>) -> Void) {
        
        let curentlat = "lat=" + lat + "&"
        let curentlon = "lon=" + lon + "&"
        let requestStr = "https://api.openweathermap.org/data/2.5/weather?" + curentlat + curentlon + "&units=metric&lang=ru&appid=9235dd62d3f74c7814a8a04526e91cab"
        
        guard let url = URL(string: requestStr) else { return }
        let resorce = Resource(url: url)
        self.load(resorce) { (result) in
            switch result {
            
            case .success(let data):
                do {
                    let parsedResult: WeatherCity = try JSONDecoder().decode(WeatherCity.self, from: data)
                    print("\(parsedResult)")
                    completion(.success(parsedResult))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
// расширение для URLRequest чтоб передать url и метод
extension URLRequest {
    
    init(_ resource: Resource) {
        self.init(url: resource.url)
        self.httpMethod = resource.method
    }
}
