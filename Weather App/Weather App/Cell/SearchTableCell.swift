//
//  SearchTableCell.swift
//  Weather App
//
//  Created by Роман Шабаев on 25.12.2021.
//

import Foundation
import UIKit

class SearchTableCell: UITableViewCell {
    
    static let reuseID = "Cell"

    var cityName = UILabel()
    var countryName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cityName)
        addSubview(countryName)
        setTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleConstraints() {
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        countryName.translatesAutoresizingMaskIntoConstraints = false
        countryName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countryName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
