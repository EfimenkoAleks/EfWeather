//
//  CityFromWeather.swift
//  EfWeather
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
//MARK: - WeatherDetail
struct WeatherCity: Codable {
    let coord: Coord1?
    let weather: [Weather1]?
    let base: String?
    let main: Main1?
    let visibility: Int?
    let wind: Wind1?
    let clouds: Clouds1?
    let dt: TimeInterval?
    let sys: Sys1?
    let id: Int?
    let name: String?
//    let cod: Int?
    
    static var placeholder: WeatherCity {
        return WeatherCity(coord: nil, weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, id: nil, name: nil)
    }
}

// MARK: - Coord
struct Coord1: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main1: Codable {
    let temp, feels_like: Double?
    let pressure, humidity: Int?
    let temp_min, temp_max: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp, feels_like, pressure, humidity
        case temp_min = "temp_min"
        case temp_max = "temp_max"
    }
}
// MARK: - Wind
struct Wind1: Codable {
    let speed: Double?
    let deg: Int?
}
// MARK: - Clouds
struct Clouds1: Codable {
    let all: Int?
}
// MARK: - Sys
struct Sys1: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise, sunset: Double?
}
// MARK: - Weather
struct Weather1: Codable {
    let id: Int?
    let name, description, icon: String?
}

