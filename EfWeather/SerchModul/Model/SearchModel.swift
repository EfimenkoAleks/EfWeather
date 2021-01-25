//
//  SearchModel.swift
//  EfWeather
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation

struct City : Decodable {
    var id: Int?
    var name: String?
    var state: String?
    var country: String?
    var coord: Coord?
}

struct Coord: Codable {
    var lon: Double?
    var lat: Double?
}
