//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by PRO on 5/7/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var weatherInfoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getWeather(_ sender: Any) {
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + (cityField.text?.replacingOccurrences(of: " ", with: "-"))! + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            var message = ""
            
            if error != nil {
                print(error.debugDescription)
            } else {
                
                if let unwrapedData = data {
                    
                    let dataString = NSString(data: unwrapedData, encoding: String.Encoding.utf8.rawValue)
                    
                    let separatorString = "7 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: separatorString) {
                        
                        if contentArray.count > 1 {
                            
                            let separatorString = "</span>"
                            
                            let newContent = contentArray[1].components(separatedBy: separatorString)
                            
                            if newContent.count > 1 {
                                
                                message = newContent[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(message)
                            }
                            
                        }
                        
                    }
                }
                
            }
            
            if message == "" {
                message = "The weather there couldn't be found. Please try again."
            }
            
            DispatchQueue.main.sync {
                self.weatherInfoLbl.text = message
            }
            
        }
        task.resume()
        } else {
            weatherInfoLbl.text = "The weather there couldn't be found. Please try again."
        }
        
    }

}

