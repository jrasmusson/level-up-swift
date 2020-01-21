//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-17.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

// Multiple files same class is fine.

protocol WeatherServiceProtocol: AnyObject {
    func didFetchWeather(_ weather: Weather)
}

struct Weather: Codable {
    let temperature: Int
    let forecast: Forecast
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case forecast
    }
    
    enum Forecast: String, Codable {
        case sunny = "sun"
        case rainy = "rain"
        case snowey = "snow"
    }
}

struct WeatherService {

    let json = """
     {
        "temp": 25,
        "forecast": "sun"
     }
    """
    
    weak var delegate: WeatherServiceProtocol?
    
    func fetchWeather(for city: String) {
        let data = json.data(using: .utf8)!
        let weather = try! JSONDecoder().decode(Weather.self, from: data)
        delegate?.didFetchWeather(weather)
    }
}
