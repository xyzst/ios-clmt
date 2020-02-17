//
//  WeatherManager.swift
//  Clmt
//
//  Created by Darren Rambaud on 2/17/20.
//  Copyright © 2020 Darren Rambaud. All rights reserved.
//

import Foundation

struct WeatherManager {
    var url = "https://api.openweathermap.org/data/2.5/weather?appid=\("YOUR_API_KEY_HERE")&units=imperial" // !!! DO NOT COMMIT THIS FILE WITH API KEY !!!
    
    func fetchBy(city: String) {
        let fqurl = "\(url)&q=\(city)"
        req(u: fqurl)
    }
    
    func req(u: String) {
        if let url = URL(string: u) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let d = data {
                    self.parse(weather: d)
                }
            }
            task.resume()
        }
    }
    
    func parse(weather: Data) {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(WeatherData.self, from: weather)
            let w = WeatherModel(
                weatherId: decoded.weather.map({w in w.id})[0],
                city: decoded.name,
                temperature: decoded.main.temp
            )
            
            print(w.weatherCondition)
            print(w.displayTemperature)
        } catch {
            print(error)
        }
    }
}