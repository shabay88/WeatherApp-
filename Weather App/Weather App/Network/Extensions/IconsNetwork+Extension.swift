//
//  IconsNetwork.swift
//  Weather App
//
//  Created by Роман Шабаев on 14.11.2021.
//
import UIKit

extension UIImageView {
    
    func setImage(_ url: URL?) {
        guard let url = url else {
            self.image = nil
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}
