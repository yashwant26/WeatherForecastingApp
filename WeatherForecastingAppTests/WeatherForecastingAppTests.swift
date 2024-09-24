//
//  WeatherForecastingAppTests.swift
//  WeatherForecastingAppTests
//
//  Created by Yashwant Kumar on 24/09/24.
//

import XCTest
@testable import WeatherForecastingApp

class WeatherForecastingAppTests: XCTestCase {

    private var sut: HomeViewModel!
    private var networkManager: MockNetworkManager!
    private var delegate: WeatherForecastDelegate!
        
    override func setUpWithError() throws {
        //delegate = MockHomeVMDelegate()
        networkManager = MockNetworkManager()
        sut = HomeViewModel(networkManager: networkManager)
        sut.delegate = delegate
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        networkManager = nil
        try super.tearDownWithError()
    }

}

class MockNetworkManager: NetworkManagerProtocol{
    var weatherMockResult: WeatherModel?
    var shouldReturnError = false
    var mockedData: Data?
    
    func getAPIData<T>(urlString: String, resultType: T.Type, completionHandler: @escaping (T?, Error?) -> Void) where T : Decodable {
        if let result = weatherMockResult as? T {
            completionHandler(result, nil)
        } else {
            completionHandler(nil, nil)
        }
    }
}

/*
class MockHomeVMDelegate: WeatherForecastDelegate {
    
    var weatheDetails: WeatherModel = WeatherModel()
    func didReceiveWeatherForecastDetails(weatherDetail: WeatherModel?, error: Error?) {
        weatheDetails = weatherDetail
    }
}*/
