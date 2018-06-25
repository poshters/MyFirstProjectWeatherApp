//
//  ViewController.swift
//  WeatherApp
//
//  Created by mac on 6/9/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableViewCell: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherData = ApiWeather().getWeatherForecastByCity(city: "Ivano-Frankivsk")
//        let weather = WeatherGetter()
//        weather.getWeather()
        print ( Realm.Configuration.defaultConfiguration)
        let dbManager = DBManager()
//         dbManager.addDB(object: weatherData)
        print(dbManager.getWeatherForecastByCity(cityName: "Ivano-Frankivsk"))
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

