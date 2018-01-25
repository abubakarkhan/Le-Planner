//
//  FirstViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //Weather API details
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "1ce0c41977d7850542e8079cb3a54f92"
    
    //Quote of the day api details
    let QUOTE_URL = "https://quotes.rest/qod"
    

    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var qutoeAuthorLabel: UILabel!
    
    //Instance varialbes
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataTemplate()
    let quoteData = QuoteDataTemplate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Fire quote of the day API Request and update UI
        getQuoteData(url: QUOTE_URL)
    }
    

    //MARK: - Netwroking
    /*********************************************************/
    
    func getWeatherData(url: String, parameters: [String : String]){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeather(json: weatherJSON)
                
            }
            else {
                let errortext = String(describing: response.result.error)
                print("Error from API: \(errortext)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    func getQuoteData(url: String){
        
        Alamofire.request(url).responseJSON {
            response in
            if response.result.isSuccess {
                
                let quoteJSON :  JSON = JSON(response.result.value!)
                
                print(quoteJSON)
                self.updateQuote(json: quoteJSON)
                
            }
            else {
                let errorText = String(describing: response.result.error)
                print("Error Quote: \(errorText)")
                self.quoteLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /*********************************************************/
    
    func updateQuote(json: JSON){
        if let quoteOfTheDay = json["contents"]["quotes"][0]["quote"].string {
            
            quoteData.quoteText = quoteOfTheDay
            quoteData.author = "- "+json["contents"]["quotes"][0]["author"].stringValue
            
            updateUIForQuoteChanges()
        }
        else {
            quoteLabel.text = ""
            qutoeAuthorLabel.text = "Quote of the day Unavailable"
        }
        
    }
    
    func updateWeather(json: JSON){
        if let temprature = json["main"]["temp"].double {
            
            //convert from kelvin to celcius
            weatherDataModel.temprature = Int(temprature - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            weatherDataModel.weatherType = json["weather"][0]["description"].stringValue
            
            updateUIForWeatherChanges()
        }
        else {
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    //MARK: - UI Changes
    /*********************************************************/
    
    func updateUIForQuoteChanges(){
        quoteLabel.text = quoteData.quoteText
        qutoeAuthorLabel.text = quoteData.author
    }
    
    func updateUIForWeatherChanges(){
        cityLabel.text = weatherDataModel.city
        weatherTypeLabel.text = "Conditions: \(weatherDataModel.weatherType)"
        tempratureLabel.text = String(weatherDataModel.temprature) + "°C"
        weatherImage.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    //MARK: - Location Manager
    /*********************************************************/
    
    //Location Updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        //Check if valid location is recieved
        if location.horizontalAccuracy > 0 {
            
            //stop updating location to save battery
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
        
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    //Failed to update location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable, check permissions"
    }
}

