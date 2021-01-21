//
//  WeatherModel.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//
import Foundation
import RxDataSources

// MARK: WeatherAPI
struct WeatherData: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezone_offset: Double?
    let current: Current?
    let hourly: [Hourly]?
    let daily: [Daily]?
    
    static var empty: WeatherData {
        return WeatherData(lat: nil, lon: nil, timezone: nil, timezone_offset: nil, current: nil, hourly: nil, daily: nil)
    }
}

// MARK: Current
struct Current: Codable {
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let temp: Double?
    let feels_like: Double?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Double?
    let uvi: Double?
    let clouds: Int?
    let visibility: Double?
    let wind_speed: Double?
    let wind_deg: Double?
    let weather: [Weather]?
}

// MARK: Hourly
struct Hourly: Codable {
    let dt: Double?
    let temp: Double?
    let feels_like: Double?
    let pressure: Double?
    let humidity: Double?
    let dew_point: Double?
    let uvi: Double?
    let clouds: Double?
    let visibility: Double?
    let wind_speed: Double?
    let wind_deg: Double?
    let weather: [Weather]?
    let pop: Double?
}

// MARK: Daily
struct Daily: Codable {
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let temp: Temp?
    let feels_like: FeelsLike?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Double?
    let wind_speed: Double?
    let wind_deg: Double?
    let weather: [Weather]?
    let clouds: Int?
    let pop: Double?
    let rain: Double?
    let uvi: Double?
}

// MARK: FeelsLike
struct FeelsLike: Codable {
    let day: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

// MARK: Temp
struct Temp: Codable {
    let day: Double?
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Model for horizontal cell

struct SectionModelH {
    var header: String!
    var items: [Hourly]
}

extension SectionModelH: SectionModelType {
    typealias Item  = Hourly
    init(original: SectionModelH, items: [Hourly]) {
        self = original
        self.items = items
    }
}

// MARK: - Model for vertical cell
struct SectionModelV {
    var header: String!
    var items: [Daily]
}

extension SectionModelV: SectionModelType {
    typealias Item  = Daily
    init(original: SectionModelV, items: [Daily]) {
        self = original
        self.items = items
    }
}
