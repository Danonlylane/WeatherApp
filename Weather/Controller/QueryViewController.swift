//
//  QueryViewController.swift
//  Weather
//
//  Created by OnlyBei on 2021/8/10.
//

import UIKit

protocol QueryViewControllerDelegate {
    func didChangeCity(city: String)
}

class QueryViewController: UIViewController {
    
    var currentCity = ""
    var delegate:QueryViewControllerDelegate?
    
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var cityTextfield: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextfield.becomeFirstResponder() //打开这个页面首先聚焦到此处，也就是打开软键盘
//        cityTextfield.resignFirstResponder() //收起软键盘
        
        currentCityLabel.text = currentCity
    }
    
    @IBAction func query(_ sender: Any) {
        dismiss(animated: true)
        
        // 判断用户不是没有输入或者输入的是空格的时候，才改变天气
        if !cityTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            delegate?.didChangeCity(city: cityTextfield.text!)
        }
        
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
