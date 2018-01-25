//
//  FirstViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //Weather API details
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "8c8f5b65ed02f777f21a3e8feac63696"

    //Instance varialbes
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
    }

    //MARK: - Netwroking
    /*********************************************************/
    
    //MARK: - JSON Parsing
    /*********************************************************/
    
    //MARK: - UI Changes
    /*********************************************************/
    
    //MARK: - Location Manager
    /*********************************************************/

}

