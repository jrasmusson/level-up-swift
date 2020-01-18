//
//  WeatherService.swift
//  WeatherService
//
//  Created by Jonathan Rasmusson Work Pro on 2019-12-08.
//  Copyright © 2019 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(weather: String)
}

struct WeatherService {
    weak var delegate: WeatherServiceDelegate?
    
    func fetchWeather() {
        // asynchronous...
        delegate?.didFetchWeather(weather: "22")
    }
}
