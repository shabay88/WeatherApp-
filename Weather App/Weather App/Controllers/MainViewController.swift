//
//  ViewController.swift
//  Weather App
//
//  Created by Роман Шабаев on 12.11.2021.
//

import UIKit

class MainViewController: UIViewController {

    lazy var weatherView = WeatherView()
    lazy var tableView = CitiesTableView()
    lazy var cities: [CitiesList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3764705882, blue: 0.5333333333, alpha: 1)
        view.addSubview(weatherView)
        view.addSubview(tableView)
        constraints()
        setNavigationButton()
    }
}

