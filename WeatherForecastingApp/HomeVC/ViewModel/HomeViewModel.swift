//
//  HomeViewModel.swift
//  WeatherForecastingApp
//
//  Created by Yashwant Kumar on 24/09/24.
//

import Foundation
import CoreLocation

protocol WeatherForecastDelegate {
    func didReceiveWeatherForecastDetails(weatherDetail: WeatherModel?, error: Error?)
}

class HomeViewModel {
    var delegate : WeatherForecastDelegate?
    var weatherModel: WeatherModel?
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getWeatherforecastDetails(cityName:String) {
        
        getLatLong(from: cityName) { (coordinates) in
            let weatherUrl = "\(WEATHER_API_BASE_URL)lat=\(coordinates?.latitude ?? 0.0)&lon=\(coordinates?.longitude ?? 0.0)&appid=\(API_KEY)"
            
            self.networkManager.getAPIData(urlString: weatherUrl, resultType: WeatherModel.self) { (weather, error) in
                
                if let weatherDetail = weather {
                    self.weatherModel = weatherDetail
                    DispatchQueue.main.async {
                        self.delegate?.didReceiveWeatherForecastDetails(weatherDetail: weatherDetail, error: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.didReceiveWeatherForecastDetails(weatherDetail: nil, error: error)
                    }
                }
            }
        }
    }
    
    //MARK:- get latitude and Longitude from the city/country name......
    func getLatLong(from city: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
                completion(nil)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
                completion(coordinates)
            }
        })
    }
}
