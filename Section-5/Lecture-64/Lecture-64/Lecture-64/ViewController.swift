//
//  ViewController.swift
//  Lecture-64
//
//  Created by Pavlo Cretsu on 3/11/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: UIButton) {
        
        self.resultLabel.text = ""
        
        if let cityNameStr = cityTextField.text {
            
            let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/\(cityNameStr.stringByReplacingOccurrencesOfString(" ", withString: "-"))/forecasts/latest")
            
            if let url = attemptedUrl {
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                    
                    if let urlContent = data {
                        
                        let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                        
                        let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                        
                        if websiteArray.count > 1 {
                            
                            let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                            
                            if weatherArray.count > 0 {
                                
                                let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
                                
                                self.displayWeatherResultWithText(weatherSummary, isSuccessful: true)
                                
                            }
                            
                        } else {
                            
                            self.displayWeatherResultWithText("Can't find short summary for selected city", isSuccessful: false)
                            
                        }
                        
                    } else {
                        
                        if error != nil {
                            
                            self.displayWeatherResultWithText("Connection error. \(error?.userInfo)", isSuccessful: false)
                            
                        } else {
                            
                            self.displayWeatherResultWithText("Received data are empty or wrong data format", isSuccessful: false)
                            
                        }
                    }
                    
                }
                
                task.resume()
                
            } else {
                
                self.displayWeatherResultWithText("Can't get weather information for this (\(cityNameStr)) city. City name contain invalid symbols", isSuccessful: false)
                
            }
            
        } else {
            
            self.displayWeatherResultWithText("Please, set city name first", isSuccessful: false)
            
        }
    }
    
    
    func displayWeatherResultWithText(text: String, isSuccessful: Bool) {
    
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.resultLabel.text = text
            
            self.resultLabel.textColor = (isSuccessful == true) ? UIColor.darkGrayColor() : UIColor.redColor()
        })
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

