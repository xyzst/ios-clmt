//
//  WeatherViewController.swift
//  Clmt
//
//  Created by Darren Rambaud on 02/16/2020.
//  Copyright © 2020 Darren Rambaud. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var search: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self // delegates used to notify other elements (eg, user end editing..)
        weatherManager.delegate = self
    }
    
    @IBAction func search(_ sender: UIButton) {
        // send api request to weather api
        print(search.text!)
        search.endEditing(true)
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
