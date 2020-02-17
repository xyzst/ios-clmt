//
//  WeatherData.swift
//  Clmt
//
//  Deserialize Open Weather Map API JSON to "Decodable" struct
//
//  Created by Darren Rambaud on 2/17/20.
//  Copyright © 2020 Darren Rambaud. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
