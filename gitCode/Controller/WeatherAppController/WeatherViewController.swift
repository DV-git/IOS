//
//  WeatherViewController.swift
//  gitCode
//
//  Created by Dimitar Vitanov on 7/7/19.
//  Copyright © 2019 Dimitar Vitanov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, changeCityDelegate {
   
    
    @IBOutlet weak var temperatueLable: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "00e789e2c2c7cf1dc71d17f66a0e34aa"
    let weatherModel = WeatherDataModel()
 let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //Asking the users to Authorize the use of the location
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    //Networking
    
    func getWeatherData(url : String, parameters: [String: String])
    {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{ response in
            if response.result.isSuccess
            {
                print("We got weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
            self.updateWeatherData(json: weatherJSON)
                
            }
            else
            {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Weather Unavailabe"
            }
            
        }
    }
    
    //JSON
    
    
    func updateWeatherData(json: JSON)
    {
        if let tmpResult = json["main"]["temp"].double{
            weatherModel.temperature = Int(tmpResult-273.15)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
            
            updateUIViewWithWeatherData()
        }
    }
    
    func updateUIViewWithWeatherData()
    {
        cityLabel.text = weatherModel.city
        weatherIcon.image = UIImage(named: weatherModel.weatherIconName)
        temperatueLable.text = String(weatherModel.temperature)
    }
    
    //CLLocationManager methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0
        {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("Longitude->", location.coordinate.longitude)
            print("Latitude->",location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            let param : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: param)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Weather Unavaliable"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChangeCity"
        {
        let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        
        }
    }
    
    func userEnteredNewCity(city: String) {
        let parms: [String : String] = ["q" : city, "appid":APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: parms)
        
    }
    @IBAction func changeCityPressed(_ sender: UIButton) {
     performSegue(withIdentifier: "toChangeCity", sender: self)
    }
    
    
    
 

}
