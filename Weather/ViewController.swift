//
//  ViewController.swift
//  Weather
//
//  Created by Anna on 06/02/2020.
//  Copyright © 2020 Anna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userCity: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func findWeather(_ sender: UIButton) {
        let city = userCity.text!
        let cityEdited = city.replacingOccurrences(of: " ", with: "_")
        let url = URL(fileURLWithPath: "http://www.weather-forecast.com/locations/" + city + "/forecasts/latest")
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            var urlError = false
            var weather = ""
            
            if error == nil {
                let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                
                let urlContentArray = urlContent? .components(separatedBy: "<span class=\"phrase\">")
                
                if (urlContentArray?.count)! > 0 {
                    let weatherArray = urlContentArray?[1].components(separatedBy: "<span>")
                    
                    weather = (weatherArray?.first!)!
                } else {
                    urlError = true
                }
            } else {
                urlError = true
            }
            
            DispatchQueue.main.async {
                if urlError == true {
                    self.showError()
                } else {
                    self.resultLabel.text = weather
                }
            }
        }
        task.resume()
    }
    
    func showError() {
        self.resultLabel.text! = "тю-тю\(self.userCity.text!)-тю-тю"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


