//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Oladipupo Olasile on 2023-10-28.
//

import UIKit

class WeatherViewController: UIViewController, WeatherGetterDelegate {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var degreesLabel: UILabel!
    
    var cityNameText: String? = ""
    
    var weatherGetter = WeatherGetter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting textfield delegate
        searchTextField.delegate = self
        weatherGetter.delegate = self
        
    }

    @IBAction func getLocationPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func searchLoaction(_ sender: UIButton) {
         let location = searchTextField.text!
        //print(location)
        searchTextField.endEditing(true)
        
    }
    
    
    //MARK: Getting weather data from weatherGetter
    
    func didUpdateWeather(_ weatherGetter: WeatherGetter, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.degreesLabel.text = weather.temperatureString + "°C"
            self.cityNameLabel.text = weather.cityName
            
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.weatherType.text = weather.description
            
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        cityNameText = searchTextField.text
       // print(cityNameText!)
        
        weatherGetter.fetchWeather(cityName: cityNameText!)
        
        searchTextField.text = ""
        
    }
    //Checking for empty textField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please enter a city name"
        }
        return false
    }
}


