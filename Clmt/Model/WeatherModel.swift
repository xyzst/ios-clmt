//
//  WeatherModel.swift
//  Clmt
//
//  Created by Darren Rambaud on 2/17/20.
//  Copyright © 2020 Darren Rambaud. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    // MARK: Stored Properties
    let weatherId: Int
    let city: String
    let temperature: Double
    
    // MARK: Computed Properties
    var displayTemperature: String {
        return String(format: "%.1f", self.temperature)
    }
    
    var weatherCondition: String {
        switch self.weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "sun.haze"
        case 800:
            return "sun.min"
        case 801...804:
            return "cloud.sun"
        default:
            return "cloud"
        }
    }
}
