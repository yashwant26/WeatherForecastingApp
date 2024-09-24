//
//  DependencyProvider.swift
//  WeatherForecastingApp
//
//  Created by Yashwant Kumar on 24/09/24.
//

import Foundation

struct DependencyProvider {
    static var networkManager : NetworkManagerProtocol {
        return NetworkManager()
    }
    
    static var homeViewModel: HomeViewModel {
        return HomeViewModel(networkManager: self.networkManager)
    }
}
