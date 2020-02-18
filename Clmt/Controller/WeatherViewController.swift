//
//  WeatherViewController.swift
//  Clmt
//
//  Created by Darren Rambaud on 02/16/2020.
//  Copyright © 2020 Darren Rambaud. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var search: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self // delegates used to notify other elements (eg, user end editing..)
        weatherManager.delegate = self
        locationManager.delegate = self
    }
    
    @IBAction func requestCurrentLocation(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func search(_ sender: UIButton) {
        // send api request to weather api
        print(search.text!)
        search.endEditing(true)
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            self.weatherManager.fetchBy(coords: locations.map({l in (l.coordinate.latitude, l.coordinate.longitude)}))
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error) // ? ux decision: display error to user ?
        }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // send api request to weather api ...
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        textField.placeholder = "Type something here, buddy!"
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // send api request to weather api
        if let c = search.text {
            weatherManager.fetchBy(city: c)
        }
        search.text = "" // reset the text field after submission
    }
}

// MARK: - WeatherDelegate

extension WeatherViewController: WeatherDelegate {
    func didWeatherUpdate(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.weatherCondition)
            self.temperatureLabel.text = weather.displayTemperature
            self.cityLabel.text = weather.city
        }
    }
}
