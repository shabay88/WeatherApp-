//
//  TableViewCell.swift
//  Weather App
//
//  Created by Роман Шабаев on 14.11.2021.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    static let reuseID = "Cell"
    private let weatherService = WeatherNetwork()
    
    private var cityName: UILabel = {
        let city = UILabel()
        city.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        city.textColor = .white
        return city
    }()
    
    private let cityTemp: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        temp.textColor = .white
        return temp
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cityName)
        addSubview(cityTemp)
        addSubview(weatherImage)
        backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3764705882, blue: 0.5333333333, alpha: 1)
        selectionStyle = .none
        configureCell()
    }
    
    private func configureCell() {
        setNameConstraints()
        seеTempConstraints()
        setImageConstraints()
    }
    
    func setCellSettings(cityInfo: CitiesList) {
        self.weatherService.fetchCurrentWeather(city: self.cityName.text ?? "") { [weak self] result in
            DispatchQueue.main.async {
                self?.cityTemp.text = "temp.: \(result.main.temp)°C"
                if let icon = result.weather.first?.icon, let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                    self?.weatherImage.setImage(iconUrl)
                } else {
                    print("error")
                }
            }
        }
    }
    
    func setSettings(cityInfo: CitiesList) {
        cityName.text = cityInfo.name
        cityTemp.text = cityInfo.temperature
    }
    
    private func seеTempConstraints() {
        cityTemp.translatesAutoresizingMaskIntoConstraints = false
        cityTemp.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        cityTemp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func setImageConstraints() {
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        weatherImage.trailingAnchor.constraint(equalTo: cityTemp.leadingAnchor, constant: -15).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setNameConstraints() {
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        cityName.heightAnchor.constraint(equalToConstant: 70).isActive = true
        cityName.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

