//
//  ShowAlert.swift
//  WeatherForecastingApp
//
//  Created by Yashwant Kumar on 24/09/24.
//

import Foundation
import UIKit

protocol ShowsAlert {}

extension ShowsAlert where Self: UIViewController {
    func showAlert(title: String = "Alert!!", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
