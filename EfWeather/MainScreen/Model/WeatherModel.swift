//
//  WeatherModel.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//
import Foundation

// MARK: MainModel
struct WeatherData: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: TimeInterval?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
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
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}
// MARK: - Sys
struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise, sunset: Double?
}
// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let name, description, icon: String?
}


