//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Oladipupo Olasile on 2023-10-28.
//

import Foundation


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    
}




struct Weather: Codable {
    let id: Int
    let description: String
}


