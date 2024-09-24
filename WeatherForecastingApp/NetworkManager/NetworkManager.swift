//
//  NetworkManager.swift
//  WeatherForecastingApp
//
//  Created by Yashwant Kumar on 24/09/24.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func getAPIData<T:Decodable>(urlString: String, resultType:T.Type, completionHandler: @escaping(_ result: T?, _ error: Error?)-> Void )
}

class NetworkManager: NetworkManagerProtocol {

    func getAPIData<T:Decodable>(urlString: String, resultType:T.Type, completionHandler: @escaping(_ result: T?, _ error: Error?)-> Void ){
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        let jsonData = Data(jsonString.utf8)
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            completionHandler(result,error)
                        } catch {
                            completionHandler(nil,error)
                        }
                    }
                } else {
                    completionHandler(nil,error)
                }
            }.resume()
        }
    }
}
