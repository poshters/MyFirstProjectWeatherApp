//
//  DBManager.swift
//  WeatherApp
//
//  Created by mac on 6/25/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
   
    @discardableResult
    class func addDB(object: WeatherForecast) -> Bool {
        do {
            
             let realm = try Realm()
            try realm.write {
            realm.deleteAll()
            realm.add(object, update: true)
            }
            return true
        } catch {
            return false
        }
    }
    
    class func  getWeatherForecastByCity(lat: Double, long: Double) -> Results<WeatherForecast>? {

        do {
            let realm = try Realm()
              let result = realm.objects(WeatherForecast.self)
            return result
//                .filter( "city.name  == %@")
           
        } catch {
            return nil
        }
        
    }
    
}
