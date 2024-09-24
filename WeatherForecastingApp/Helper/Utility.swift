//
//  Utility.swift
//  WeatherForecastingApp
//
//  Created by Yashwant Kumar on 24/09/24.
//

import Foundation
import UIKit

open class Utility {
    
    class func convertKelvinToCelsius(kelvin: Double) -> Int {
        return Int(kelvin - 273.15)
    }
    
    class func convertDateFormat(sourceDateString : String, sourceDateFormat : String, destinationFormat : String) -> String{
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = sourceDateFormat;
        
        if let date = dateFormatter.date(from: sourceDateString){
            dateFormatter.dateFormat = destinationFormat;
            return dateFormatter.string(from: date)
        }else{
            return ""
        }
    }
}
