

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
      
        self.view.addSubview(myScrolView)
        setImageBackground()
        setInfoWether()
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
    
    
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
    
    func setImageBackground() {
        let backgroundImage = UIImageView (frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage (named: "1")
       
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview (backgroundImage, at: 0)
        
    }

}






