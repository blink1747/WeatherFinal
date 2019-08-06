//
//  ViewController.swift
//  WeatherFinal
//
//  Created by IMCS on 8/5/19.
//  Copyright © 2019 IMCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextInput: UITextField!
    
    @IBOutlet weak var TextDisplay: UILabel!
    @IBAction func GetWeather(_ sender: Any) {
        let str = "https://api.openweathermap.org/data/2.5/weather?q=\(TextInput.text!)&appid=5e121734cd62462241b19f20b27b42a9".replacingOccurrences(of: " ", with: "+")
        
        let url = URL(string: str )
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                if let unWrappedData = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: unWrappedData, options : JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        print(jsonResult)
                        
                        if jsonResult!["weather"] != nil {

                        let weather = jsonResult?["weather"] as? NSArray
                        let weatherItem = weather?[0] as? NSDictionary
                        var description = weatherItem!["description"] as! String
                        DispatchQueue.main.async {
                            self.TextDisplay.text = description
                        }
                        } else{
                        
                        DispatchQueue.main.async {
                            let message = jsonResult?["message"] as! String
                            self.TextDisplay.text = message
                        }
                        }
                    } catch {
                        print("Error fetching API Data")
                    }
                    
                }
            }
        }
        task.resume()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var img = UIImage(named: "wallpaper.jpg")
        view.layer.contents = img?.cgImage
    }
    

}



