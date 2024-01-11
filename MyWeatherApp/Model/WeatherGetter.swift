//
//  WeatherGetter.swift
//  MyWeatherApp
//
//  Created by Oladipupo Olasile on 2023-10-28.
//

import Foundation

protocol WeatherGetterDelegate {
    func didUpdateWeather(_ weatherGetter: WeatherGetter, weather: WeatherModel)
    func didFailWithError(error: Error)
    
}

struct WeatherGetter {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=//removedKey&units=metric"
    
    var delegate: WeatherGetterDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //URL
        if let url = URL(string: urlString) {
            
            // URLSESSION
            let session = URLSession(configuration: .default)
            
            //task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
                
            }
            
            //Start task
            task.resume()
        }
    }
    
    // json formatting
     func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let humidity = decodedData.main.humidity
            let description = decodedData.weather[0].description
            let min_temp = decodedData.main.temp_min
            let max_temp = decodedData.main.temp_max
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, humidity: humidity, description: description, min_temp: min_temp, max_temp: max_temp)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
        
    
    
}
