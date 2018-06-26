//
//  ApiWeather.swift
//  WeatherApp
//
//  Created by mac on 6/21/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import RealmSwift


class ApiWeather{
    let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/forecast/daily?mode=json&units=metric&cnt=14"
    let openWeatherMapAPIKey = "695ec8629eeaf925d9d4e9139ac14a69"
   
    func getWeatherForecastByCity(city: String) -> WeatherForecast  {
        let semaphore = DispatchSemaphore(value: 0)
        var responseModel : WeatherForecast?
        let session = URLSession.shared
        
        
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)&APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        session.dataTask(with: weatherRequestURL) { (data, response, error) in
            
            guard response != nil else {return}
            guard let data = data else {return}
            guard  error == nil else {return}
            let jsonDecoder = JSONDecoder()
            do {
                responseModel = try jsonDecoder.decode(WeatherForecast.self, from: data)
                semaphore.signal()
                }catch {
            print(error)
        }
    }
            
    .resume()
        semaphore.wait()
        return responseModel!
}
    }
    

