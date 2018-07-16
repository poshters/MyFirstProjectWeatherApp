import UIKit

class InfoViewController: UIViewController {
    let wetherTableView = WeatherTableViewController()
    var selectedRow = Weather()
    
    let dateFormatter = DateFormatter()
    let dayOfWeek = DateFormatter()
   
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.clipsToBounds = true
        setImageBackground()
        setInfoWether()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}

    func setInfoWether() {
        let date = Date(timeIntervalSince1970: TimeInterval(selectedRow.dateWeather))
        dayOfWeek.dateFormat = "EEEE"
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        dayLabel.text = "\(dayOfWeek.string(from: date))\n\(dateFormatter.string(from: date))"
        maxTempLabel.text = "\(Int(selectedRow.max))ºC"
        minTempLabel.text = "\(Int(selectedRow.min))ºC"
        descriptionLabel.text = "\(selectedRow.desc)"
        humidityLabel.text = "Humidity: \(selectedRow.humidity) %"
        pressureLabel.text = "Pressure: \(Int(selectedRow.pressure)) hPa"
        windLabel.text = "Wind: \(Int(selectedRow.speed)) km/h"
        iconImage.image = UIImage(named: selectedRow.icon)
}
    
    func setImageBackground() {
        let backgroundImage = UIImageView(image: UIImage(named: "1"))
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(backgroundImage, at: 0)
        
        NSLayoutConstraint.activate([backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
                                     backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

}
