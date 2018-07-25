import UIKit

class InfoViewController: UIViewController {
    private let wetherTableView = WeatherTableViewController()
    private let dateFormatter = DateFormatter()
    private let dayOfWeek = DateFormatter()
    var selectedRow = Weather()
   
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

  private func setInfoWether() {
        dayLabel.text = "\(Utils.dayOfWeeks(date: selectedRow.dateWeather))"
        maxTempLabel.text = Utils.temperatureFormatter(kelvinTemp: selectedRow.max)
        minTempLabel.text = Utils.temperatureFormatter(kelvinTemp: selectedRow.min)
        descriptionLabel.text = "\(selectedRow.desc)"
        humidityLabel.text = "Humidity: \(selectedRow.humidity) %"
        pressureLabel.text = "Pressure: \(Int(selectedRow.pressure)) hPa"
        windLabel.text = "Wind: \(Int(selectedRow.speed)) km/h"
        iconImage.image = UIImage(named: selectedRow.icon)
}
    
   private func setImageBackground() {
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
