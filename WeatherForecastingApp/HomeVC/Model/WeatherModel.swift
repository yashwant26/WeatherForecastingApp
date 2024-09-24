//
//  WeatherModel.swift
//  WeatherForecastingApp
//
//  Created by Yashwant Kumar on 24/09/24.
//

import Foundation

struct WeatherModel: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let city: City
    let list: [List]
}

struct City : Decodable{
    let id: Int
    let name: String
    let country: String
    let timezone: Int
    let coord: Coordinates
}

struct Coordinates: Decodable {
    let lat: Double
    let lon: Double
}

struct List: Decodable {
    let dt: Int
    let visibility: Int
    let pop: Double
    let dt_txt: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    let feels_like: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}


