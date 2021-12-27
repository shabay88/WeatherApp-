//
//  TabbleView.swift
//  Weather App
//
//  Created by Роман Шабаев on 14.11.2021.
//

import UIKit

class CitiesTableView: UITableView, UITableViewDataSource {
    
    var city: [CitiesList] = []
    
    init() {
        city = MainViewController.collectionObjects()
        super.init(frame: .zero, style: .plain)
        dataSource = self
        backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3764705882, blue: 0.5333333333, alpha: 1)
        rowHeight = 70
        register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseID)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseID) as! DailyTableViewCell
        let cities = city[indexPath.row]
        cell.setSettings(cityInfo: cities)
        cell.setCellSettings(cityInfo: cities)
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
