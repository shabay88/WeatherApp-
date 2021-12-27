//
//  NetworkProtocol.swift
//  Weather App
//
//  Created by Роман Шабаев on 22.11.2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCurrentWeather(city: String, completionHandler: @escaping (WeatherResponse) -> ())
}
