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
    
    @IBOutlet weak var tableView: UITableView!
    let identifier = "myCell"
    let weatherData = ApiWeather().getWeatherForecastByCity(city: "Ivano-Frankivsk")
    let dbManager = DBManager().getWeatherForecastByCity(cityName: "Ivano-Frankivsk")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (Realm.Configuration.defaultConfiguration)
        label.text = dbManager.city?.name

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbManager.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let number = dbManager.list[indexPath.row]
        let date = Date(timeIntervalSince1970: TimeInterval(number.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        cell.textLabel?.text = "\(dateFormatter.string(from:date)) | \(number.desc) | \(round(number.min))/\(round(number.max))"
        cell.textLabel?.center
        return cell
    }
}

