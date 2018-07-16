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
    
    class func getWeatherForecastByCity(cityName: String) -> Results<WeatherForecast>? {
        do {
            let realm = try Realm()
            let result = realm.objects(WeatherForecast.self).filter("city.name == %@", cityName)
            return result
        } catch {
            return nil
        }
    }
    
}
