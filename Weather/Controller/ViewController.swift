//
//  ViewController.swift
//  Weather
//
//  Created by OnlyBei on 2021/8/10.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "QueryViewControllerSegue" {
//        let vc = segue.destination as! QueryViewController
//        vc.currentCity = weather.city
//        }
        
        // 在跳转之前，需要准备一些数据
        
        if let vc = segue.destination as? QueryViewController { // 判断跳转的是否是搜索页
            vc.currentCity = weather.city
            vc.delegate = self
        }
    }
}
