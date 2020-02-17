//
//  WeatherDelegate.swift
//  Clmt
//
//  Created by Darren Rambaud on 2/17/20.
//  Copyright © 2020 Darren Rambaud. All rights reserved.
//

import Foundation

protocol WeatherDelegate {
    func didWeatherUpdate(weather: WeatherModel)
}
