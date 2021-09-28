//
//  ViewController-CLLocationManagerDelegate.swift
//  Weather
//
//  Created by OnlyBei on 2021/8/11.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lon = locations[0].coordinate.longitude
        let lat = locations[0].coordinate.latitude
        
        AF.request(kQWeatherNowPath, parameters: getParameters("\(lon),\(lat)")).responseJSON { response in
            if let data = response.value{
                let weatherJSON = JSON(data)
                self.showWeather(weatherJSON)
            }
        }
        AF.request(kQWeatherNowCityPath, parameters: getParameters("\(lon),\(lat)")).responseJSON { responseCity in
            if let cityData = responseCity.value{
                let weatherCityJSON = JSON(cityData)
                self.showCity(weatherCityJSON)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "获取地理位置失败"
    }
}
