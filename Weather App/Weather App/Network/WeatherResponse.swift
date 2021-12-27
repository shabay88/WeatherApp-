//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Роман Шабаев on 22.11.2021.
//

import Foundation

class WeatherNetwork: NetworkManagerProtocol {
    
    func fetchCurrentWeather(city: String, completionHandler: @escaping (WeatherResponse) -> ()) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&lang=en&units=metric&appid=2a5f8913bcbee5cf5a28aa3e122da8ef"
        guard let url = URL(string: url) else {
            return print("error")
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let currentWeather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completionHandler(currentWeather)
            } catch {
                print("error")
            }
        }.resume()
    }
    
    func searchCoordinate(locationName: String ,completion: @escaping (Result<[LocationResponse], Error>) -> Void ) {
        let url = "https://api.openweathermap.org/geo/1.0/direct?q=\(locationName)&limit=5&appid=2a5f8913bcbee5cf5a28aa3e122da8ef"
        let task = URLSession.shared.dataTask(with: URL(string: url)! ) { data, response, error in

            if error != nil {
                print(error ?? "")
            }
            guard let data = data else {
               return
            }
            do {
                let locationInfo = try JSONDecoder().decode([LocationResponse].self, from: data)
                completion(.success(locationInfo))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }

        task.resume()


    }
}
