//
//  SearchViewController.swift
//  Weather App
//
//  Created by Роман Шабаев on 25.12.2021.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    var searchResults: [LocationResponse] = []
    private var tableView = UITableView()
    private let weatherService = WeatherNetwork()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "City name"
        search.searchBarStyle = .minimal
        search.isTranslucent = false
        search.showsCancelButton = true
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setParameters()
    }
    
    private func setParameters() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        searchBar.delegate = self
        setConstraints()
        setTableParameters()
    }
    
    private func setTableParameters() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
        tableView.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.reuseID)
    }
    
    private func setConstraints() {
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: -380).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 30).isActive = true
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.weatherService.searchCoordinate(locationName: searchText) { result in
                switch result {
                case .success(let location):
                    self.searchResults = location
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.reuseID) as! SearchTableCell
        cell.cityName.text = searchResults[indexPath.row].name
        cell.countryName.text = searchResults[indexPath.row].country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newLocationController = NewLocationViewController()
        let location = searchResults[indexPath.row]
        newLocationController.setDetailSettings(cityInfo: location)
        newLocationController.loadData(city: location)
        self.present(newLocationController, animated: true, completion: nil)
    }
}
