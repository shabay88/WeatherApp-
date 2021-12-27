//
//  WeatherModel.swift
//  Weather App
//
//  Created by Роман Шабаев on 13.11.2021.
//

import UIKit

struct WeatherCondittions: Decodable {
    let description: String
    let icon: String
    
    private enum CodingKeys: String, CodingKey {
        case description = "description"
        case icon = "icon"
    }
}

struct MainCondittions: Decodable {
    typealias Temperature = Double
    let temp: Temperature
    let temp_min: Temperature
    let temp_max: Temperature
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
    }
}

struct WeatherResponse: Decodable {
    let weather: [WeatherCondittions]
    let main: MainCondittions
    let name: String
}

struct LocationResponse: Codable {
    var name: String
    var country: String
}
