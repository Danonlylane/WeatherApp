//
//  ViewController-Helper.swift
//  Weather
//
//  Created by OnlyBei on 2021/8/11.
//

import Foundation
import SwiftyJSON

extension ViewController{
    func showWeather(_ weatherJSON: JSON){
        
        weather.temp = "\(weatherJSON["now","temp"].stringValue)˚"
        weather.icon = weatherJSON["now","icon"].stringValue
        
        tempLabel.text = self.weather.temp
        iconImageView.image = UIImage(named: weather.icon)
    }
    
    func showCity(_ weatherCityJSON: JSON){
        weather.city = weatherCityJSON["location",0,"name"].stringValue
        cityLabel.text = weather.city
    }
    
    func getParameters(_ location: String) -> [String: String]{
        ["location": location, "key": kQweatherWebKey]
    }
}
