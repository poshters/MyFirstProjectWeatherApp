//
//  ViewController.swift
//  WeatherApp
//
//  Created by mac on 6/28/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    let wetherTableView = WeatherTableViewController()
    var selectedRow = Weather()
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoWether()
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    
    
}

    func setInfoWether() {
        let date = Date(timeIntervalSince1970: TimeInterval(selectedRow.dt))
        let dateFormatter = DateFormatter()
        let dayOfWeek = DateFormatter()
        dayOfWeek.dateFormat = "EEEE"
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        dayLabel.text = "\(dayOfWeek.string(from:date))\n\(dateFormatter.string(from:date))"
        maxTempLabel.text = "\(Int(selectedRow.max))ºC"
        minTempLabel.text = "\(Int(selectedRow.min))ºC"
        descriptionLabel.text = "\(selectedRow.desc)"
        humidityLabel.text = "Humidity: \(selectedRow.humidity) %"
        pressureLabel.text = "Pressure: \(Int(selectedRow.pressure)) hPa"
        windLabel.text = "Wind: \(Int(selectedRow.speed)) km/h"
        iconImage.image = UIImage(named: selectedRow.icon)
}
}
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
