//
//  WeatherViewController.swift
//  Clmt
//
//  Created by Darren Rambaud on 02/16/2020.
//  Copyright © 2020 Darren Rambaud. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var search: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self // delegates used to notify other elements (eg, user end editing..)
    }

    @IBAction func search(_ sender: UIButton) {
        // send api request to weather api
        print(search.text!)
        search.endEditing(true)
    }
    
    // MARK: Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // send api request to weather api ...
        print(search.text!)
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // perform some validation here
        if textField.text != "" {
            return true
        }
        textField.placeholder = "Type something here, buddy!"
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // send api request to weather api
        search.text = "" // reset the text field after submission
    }
}

