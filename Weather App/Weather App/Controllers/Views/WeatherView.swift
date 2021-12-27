//
//  CollectionView.swift
//  Weather App
//
//  Created by Роман Шабаев on 13.11.2021.
//

import UIKit

class WeatherView: UIView {
    
    private let weatherService = WeatherNetwork()
    lazy var tableView = CitiesTableView()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherImage)
        addSubview(temperatureLabel)
        addSubview(maxMinTemp)
        addSubview(cityLabel)
        addSubview(descriptionLabel)
        addSubview(tableView)
        setConstraints()
        loadData(city: "Riga")
    }
    
    func loadData(city: String) {
        weatherService.fetchCurrentWeather(city: city) { [weak self] result in
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
        
        cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 110).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        weatherImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 6).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        maxMinTemp.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6).isActive = true
        maxMinTemp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        maxMinTemp.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController {
    
    func constraints() {
        view.addSubview(weatherView)
        weatherView.topAnchor.constraint(equalTo: view.topAnchor, constant: -5).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 330).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func setNavigationButton() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(cityHandler))]
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(addCity))]
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func cityHandler(sender: UIButton!) {
        let alertController = UIAlertController(title: "Change city", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "City Name"
        }
        
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            guard let cityname = firstTextField.text else { return }
            self.weatherView.loadData(city: cityname)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func addCity(sender: UIButton!) {
        self.present(SearchViewController(), animated: true, completion: nil)
    }
}

