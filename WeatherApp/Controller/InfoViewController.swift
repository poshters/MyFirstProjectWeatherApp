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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        setInfoWether()
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    func setInfoWether() {
        let date = Date(timeIntervalSince1970: TimeInterval(selectedRow.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        dayLabel.text = "\(dateFormatter.string(from:date))"
        maxTempLabel.text = "\(selectedRow.max)"
        minTempLabel.text = "\(selectedRow.min)"
        descriptionLabel.text = "\(selectedRow.desc)"
        humidityLabel.text = "\(selectedRow.humidity)"
        pressureLabel.text = "\(selectedRow.pressure)"
        windLabel.text = "\(selectedRow.speed)"
        iconImage.image = UIImage(named: selectedRow.icon)
    }
}
