//
//  ViewController-QueryViewControllerDelegate.swift
//  Weather
//
//  Created by OnlyBei on 2021/8/11.
//

import Foundation
import Alamofire
import SwiftyJSON


extension ViewController: QueryViewControllerDelegate{
    func didChangeCity(city: String) {
//        print(city)
        AF.request(kQWeatherNowCityPath, parameters: getParameters(city)).responseJSON { responseCity in
            if let cityData = responseCity.value{
                let weatherCityJSON = JSON(cityData)
                self.showCity(weatherCityJSON)
                
                let cityID = weatherCityJSON["location", 0 , "id"].stringValue
                AF.request(kQWeatherNowPath, parameters: self.getParameters(cityID)).responseJSON { response in
                    if let data = response.value{
                        let weatherJSON = JSON(data)
                        self.showWeather(weatherJSON)
                    }
                }
                
            }
        }
    }
}
