//
//  WeatherDataTemplate.swift
//  Le Planner
//
//  Created by Abubakar Khan on 25/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import Foundation

class WeatherDataTemplate {
    
    var temprature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    var weatherType : String = ""
    
    //return string for icon name
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "storm"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower"
            
        case 601...700 :
            return "snow"
            
        case 701...771 :
            return "fog"
            
        case 772...800 :
            return "storm1"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy"
            
        case 900...903, 905...1000  :
            return "storm2"
            
        case 903 :
            return "snow2"
            
        case 904 :
            return "sunny"
            
        default :
            return "sunny"
        }
        
    }
    
}
