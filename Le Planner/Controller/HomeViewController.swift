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
import SwiftySound
import SVProgressHUD
import CoreData

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //Weather API details
    private let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    private let APP_ID = "1ce0c41977d7850542e8079cb3a54f92"
    
    //Quote of the day api details
    private let QUOTE_URL = "https://quotes.rest/qod"
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Weather Section views
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    //Quote section views
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteAuthorLabel: UILabel!
    //Event section views
    @IBOutlet weak var eventSummary: UITextView!
    
    
    //Instance varialbes
    private let locationManager = CLLocationManager()
    private let weatherDataModel = WeatherDataTemplate()
    private let quoteData = QuoteDataTemplate()
    private var refresher : UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Pull to refresh
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(HomeViewController.refreshData), for: UIControlEvents.valueChanged)
        scrollView.addSubview(refresher)

        //Fetch Data
        fetchWeatherANdQutoe()
    }
    override func viewDidAppear(_ animated: Bool) {
        checkForEvents()
    }
    
    //MARK: - Pull to refresh
    @objc func refreshData(){
        fetchWeatherANdQutoe()
        refresher.endRefreshing()
        Sound.play(file: "refreshSound.wav")
    }
    
    //MARK - Location and quote setup
    private func fetchWeatherANdQutoe(){
        //Progress message
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Updating Widgets")
        
        //Location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Fire quote of the day API Request and update UI
        getQuoteData(url: QUOTE_URL)
    }
    
    //MARK: - Check for pending events for the day
    private func checkForEvents(){
        var eventArray = [Event]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        
        do {
            eventArray = try context.fetch(request)
        } catch {
            print("Error loading events: \(error)")
        }
        
        updateUIEventSection(events: eventArray)
    }
    
    //MARK: - Netwroking
    /*********************************************************/
    
    private func getWeatherData(url: String, parameters: [String : String]){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeather(json: weatherJSON)
                
                //Dismiss progress message
                SVProgressHUD.dismiss()
            }
            else {
                let errortext = String(describing: response.result.error)
                print("Error from API: \(errortext)")
                self.weatherTypeLabel.text = "Connection Issues"
                self.cityLabel.text = ""
                self.tempratureLabel.text = ""
                
                //Dismiss progress message
                SVProgressHUD.dismiss()
            }
        }
    }
    
    private func getQuoteData(url: String){
        
        Alamofire.request(url).responseJSON {
            response in
            if response.result.isSuccess {
                
                let quoteJSON :  JSON = JSON(response.result.value!)
                
                self.updateQuote(json: quoteJSON)
                
            }
            else {
                let errorText = String(describing: response.result.error)
                print("Error Quote: \(errorText)")
                self.quoteAuthorLabel.text = "Connection Issues"
                self.quoteLabel.text = ""
            }
        }
    }
    
    //MARK: - JSON Parsing
    /*********************************************************/
    
    private func updateQuote(json: JSON){
        if let quoteOfTheDay = json["contents"]["quotes"][0]["quote"].string {
            
            quoteData.quoteText = quoteOfTheDay
            quoteData.author = "- "+json["contents"]["quotes"][0]["author"].stringValue
            
            updateUIForQuoteChanges()
        }
        else {
            quoteLabel.text = ""
            quoteAuthorLabel.text = "Quote of the day Unavailable"
        }
    }
    
    private func updateWeather(json: JSON){
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
            weatherTypeLabel.text = "Weather Unavailable"
            cityLabel.text = ""
            tempratureLabel.text = ""
        }
    }
    
    //MARK: - UI Changes
    /*********************************************************/
    
    private func updateUIForQuoteChanges(){
        quoteLabel.text = quoteData.quoteText
        quoteAuthorLabel.text = quoteData.author
    }
    
    private func updateUIForWeatherChanges(){
        cityLabel.text = weatherDataModel.city
        weatherTypeLabel.text = "Conditions: \(weatherDataModel.weatherType)"
        tempratureLabel.text = String(weatherDataModel.temprature) + "°C"
        weatherImage.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    private func updateUIEventSection(events: [Event]) {
        var summaryText = "No pending events for the day"
        //Update Label: No events added
        if events.count != 0  {
            
            summaryText = ""
            
            for i in events {
            
                let eventDate = Date(timeIntervalSince1970: i.date)
                let calendar = NSCalendar.current
                
                if calendar.isDateInToday(eventDate) {
                    summaryText.append("Event: \(i.title!)")
                    summaryText.append("\nDate:  \(eventDate) \n\n")
                }
                
            }
            
            //Update label: No events for today
            if summaryText.isEmpty {
                summaryText = "No Pending Events For the day"
            }
        }
        
        
        eventSummary.text = summaryText
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
        
        weatherTypeLabel.text = "Check permissions"
        cityLabel.text = ""
        tempratureLabel.text = "Location Unavailable"
        
        
        //Dismiss progress message
        SVProgressHUD.dismiss()
    }
}

