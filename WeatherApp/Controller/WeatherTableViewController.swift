import UIKit
import RealmSwift
import CoreLocation
import GooglePlaces

class WeatherTableViewController: UITableViewController {
    var getWeatherDB = WeatherForecast()
    let refresh = UIRefreshControl()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        print("lat \(UserDefaults.standard.double(forKey: "lat")) long \(UserDefaults.standard.double(forKey: "long"))")
        setImageBackground()
        self.refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.view.addSubview(refresh)
        checkData()
        self.title = "\("WeatherApp")"
    }

    @objc func refreshData() {
         locationManager.requestLocation()
            checkData()
            tableView.reloadData()
            refresh.endRefreshing()
    }
    func checkData() {
        let results = getDBApi(lat: UserDefaults.standard.double(forKey: "lat"), long: UserDefaults.standard.double(forKey: "long"))
        if results == nil {
            alertClose()
        } else if let resultFirst = (results?.first) {
            getWeatherDB = resultFirst
        
        }
    }
    
    func alertClose() {
        let alert = UIAlertController(title: "Error", message: "No connection to the internet", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try again", style: .cancel) { (_) in
            self.refreshData()
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getWeatherDB.list.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 240.0
        } else {
            return 74.0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellGetWeatherDB = getWeatherDB.list[indexPath.row]
        let date = Date(timeIntervalSince1970: TimeInterval(cellGetWeatherDB.dateWeather))
        let dateFormatter = DateFormatter()
        let dayOfWeek = DateFormatter()
        dayOfWeek.dateFormat = "EEEE"
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell",
                                                                        for: indexPath) as? TableViewCell {
            cell.cityLabel.text = "\( getWeatherDB.city?.name ?? "")"
            cell.dateWeather.text = "\(dayOfWeek.string(from: date))\n\(dateFormatter.string(from: date))"
            cell.desc.text = "\(cellGetWeatherDB.desc)"
            cell.maxTemp.text = String(format: "%.0f", cellGetWeatherDB.max - 273.15)
            cell.minTemp.text = String(format: "%.0f", cellGetWeatherDB.min - 273.15)
            cell.imageWeather.image = UIImage(named: "\(cellGetWeatherDB.icon)")
            cell.backgroundColor = .clear
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                           for: indexPath)
            as? SecondTableViewCell {
            cell.secondDate.text = "\(dayOfWeek.string(from: date)), \(dateFormatter.string(from: date))"
            cell.secondDesc.text = "\(cellGetWeatherDB.desc)"
            cell.secondMax.text = String(format: "%.0f", cellGetWeatherDB.max - 273.15)
            cell.secondMin.text = String(format: "%.0f", cellGetWeatherDB.min - 273.15)
            cell.secondImage.image = UIImage(named: "\(cellGetWeatherDB.icon)")
            cell.backgroundColor = UIColor(white: 1, alpha: 0.7)
            return cell
        }
        return UITableViewCell()
    }
    
    var selectedRoW = Weather()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoW = getWeatherDB.list[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "infoVC", sender: self)
        
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "infoVC" {
            (segue.destination as? InfoViewController)?.selectedRow = selectedRoW
        }
    }
    func getDBApi(lat: Double, long: Double) -> Results<WeatherForecast>? {
        if Reachability.isConnectedToNetwork() {
            let getApiWeather =
                ApiWeather().getWeatherForecastByCity(lat: lat, long: long )
            DBManager.addDB(object: getApiWeather)
        }
        let results = DBManager.getWeatherForecastByCity(lat: lat, long: long)
        
        return results
        
    }
    @IBAction func findeCityButton(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
     
    }
    
    func setImageBackground() {
        let backgraundImage = UIImage(named: "1")
        let imageView = UIImageView(image: backgraundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }
}
extension WeatherTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude,
        let long = locations.last?.coordinate.longitude {
        UserDefaults.standard.set(lat, forKey: "lat")
        UserDefaults.standard.set(long, forKey: "long")
           
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
extension WeatherTableViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
    
       let findeCity = getDBApi(lat: place.coordinate.latitude, long: place.coordinate.latitude)
        let results = findeCity
        if results == nil {
            alertClose()
        } else if let resultFirst = (results?.first) {
            getWeatherDB = resultFirst
            
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
       
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
