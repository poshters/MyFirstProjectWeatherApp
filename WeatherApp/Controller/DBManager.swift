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
     var realm : Realm
    static let sharedInstance = DBManager()
     init () {
        realm = try! Realm()
    }

    func addDB(object:WeatherForecast) {
        try! realm.write {
            realm.deleteAll()
            realm.add(object, update: true)
        }
    }
    func getWeatherForecastByCity(cityName: String) -> WeatherForecast {
        let result : WeatherForecast = realm.objects(WeatherForecast.self).filter("city.name == %@", cityName).first!
        return result
    }


}
