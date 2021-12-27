//
//  TableModel.swift
//  Weather App
//
//  Created by Роман Шабаев on 15.11.2021.
//

import UIKit

struct CitiesList {
    var name: String
    var temperature: String
}

extension UIViewController {
    static func collectionObjects() -> [CitiesList] {
        let first = CitiesList(name: "Voronezh", temperature: "")
        let second = CitiesList(name: "Sochi", temperature: "")
        let third = CitiesList(name: "Kazan", temperature: "")
        let fourh = CitiesList(name: "Krasnodar", temperature: "")
        let fivths = CitiesList(name: "Rostov", temperature: "")
        return [first, second, third, fourh, fivths]
    }
}
