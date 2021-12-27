//
//  NewLocationViewController.swift
//  Weather App
//
//  Created by Роман Шабаев on 26.12.2021.
//

import Foundation
import UIKit

protocol AddNewCityProtocol {
    func addLocation(city: CitiesList)
}

class NewLocationViewController: UIViewController {
    
    private let weatherService = WeatherNetwork()
    private let saveButton = UIButton()
    private let doneButton = UIButton()
    
    var cityLocation: LocationResponse?
    var delegate: AddNewCityProtocol?
    
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let cityLabel: UILabel = {
        let city = UILabel()
        city.translatesAutoresizingMaskIntoConstraints = false
        city.textColor = .white
        city.font = .systemFont(ofSize: 45, weight: .regular)
        return city
    }()
    
    private let temperatureLabel: UILabel = {
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.textColor = .white
        temperature.font = .systemFont(ofSize: 32, weight: .bold)
        return temperature
    }()
    
    private let maxMinTemp: UILabel = {
        let max = UILabel()
        max.translatesAutoresizingMaskIntoConstraints = false
        max.textColor = .white
        max.font = .systemFont(ofSize: 16, weight: .semibold)
        return max
    }()
    
    private let descriptionLabel: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.textColor = .white
        status.font = .systemFont(ofSize: 16, weight: .semibold)
        return status
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3764705882, blue: 0.5333333333, alpha: 1)
        configureView()
    }
    
    private func configureView() {
        makeSaveButton()
        makeDoneButton()
        view.addSubview(weatherImage)
        view.addSubview(temperatureLabel)
        view.addSubview(maxMinTemp)
        view.addSubview(cityLabel)
        view.addSubview(descriptionLabel)
        setConstraints()
    }
    
    func setDetailSettings(cityInfo: LocationResponse) {
        cityLabel.text = cityInfo.name
    }
    
    func loadData(city: LocationResponse) {
        weatherService.fetchCurrentWeather(city: city.name) { [weak self] result in
            DispatchQueue.main.async {
                self?.cityLabel.text = result.name
                self?.temperatureLabel.text = "\(result.main.temp)°"
                self?.descriptionLabel.text = result.weather.map(\.description).joined(separator: ", ")
                self?.maxMinTemp.text = "max.: \(result.main.temp_max), min.: \(result.main.temp_min)"
                if let icon = result.weather.first?.icon, let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                    self?.weatherImage.setImage(iconUrl)
                } else {
                    print("error")
                }
            }
        }
    }
    
    private func setConstraints() {
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        weatherImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 6).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        maxMinTemp.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6).isActive = true
        maxMinTemp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        maxMinTemp.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func makeSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        self.view.addSubview(saveButton)
        setSaveButtonConstraints()
    }
    
    private func makeDoneButton() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        self.view.addSubview(doneButton)
        setDoneButtonConstraints()
    }
    
    private func setSaveButtonConstraints() {
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setDoneButtonConstraints() {
        doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    @objc func doneButtonAction(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonAction(sender: UIButton) {
        guard let addCity = cityLabel.text else {
            print("eror")
            return
        }
        
        let newCity = CitiesList(name: addCity, temperature: "")
        delegate?.addLocation(city: newCity)
        print(newCity)
    }
}

extension MainViewController: AddNewCityProtocol {
    func addLocation(city: CitiesList) {
        self.dismiss(animated: true)
        self.cities.append(city)
        tableView.reloadData()
    }
}

