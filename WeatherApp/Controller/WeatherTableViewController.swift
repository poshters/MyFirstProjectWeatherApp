import UIKit
import RealmSwift
import CoreLocation
import GooglePlaces

class WeatherTableViewController: UITableViewController {
    private var getWeatherDB = WeatherForecast()
    private let refresh = UIRefreshControl()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        setImageBackground()
        self.refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.view.addSubview(refresh)
        self.navigationItem.title = "WeatherApp"
        checkData()
        
    }
    
    @objc private func refreshData() {
        locationManager.requestLocation()
        checkData()
        tableView.reloadData()
        refresh.endRefreshing()
    }
    private func checkData() {
        let results = getDBApi(lat: UserDefaults.standard.double(forKey: "lat"),
                               long: UserDefaults.standard.double(forKey: "long"))
        if results?.isEmpty ?? true {
            alertClose()
        } else if let resultFirst = (results?.first) {
            getWeatherDB = resultFirst
            
        }
    }
    
    private func alertClose() {
        let alert = UIAlertController(title: "Error", message: "No connection to the internet", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try again", style: .cancel) { (_) in
            self.refreshData()
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell",
                                                                        for: indexPath) as? TableViewCell {
            cell.setDataWeather(city: "\( getWeatherDB.city?.name ?? "")",
                dateWeather: "\(Utils.dayOfWeeks(date: cellGetWeatherDB.dateWeather, separateDataAndDay: true ))",
                maxTemp: Utils.temperatureFormatter(kelvinTemp: cellGetWeatherDB.max),
                minTemp: Utils.temperatureFormatter(kelvinTemp: cellGetWeatherDB.min),
                desc: "\(cellGetWeatherDB.desc)")
            cell.seImageWeather(imageWeather: "\(cellGetWeatherDB.icon)")
            cell.backgroundColor = .clear
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                           for: indexPath)
            as? SecondTableViewCell {
            cell.setDataWeather(secondImage: "\(cellGetWeatherDB.icon)",
                secondDate: "\(Utils.dayOfWeeks(date: cellGetWeatherDB.dateWeather))",
                secondMax: Utils.temperatureFormatter(kelvinTemp: cellGetWeatherDB.max),
                secondMin: Utils.temperatureFormatter(kelvinTemp: cellGetWeatherDB.min),
                secondDesc: "\(cellGetWeatherDB.desc)")
            cell.backgroundColor = UIColor(white: 1, alpha: 0.7)
            return cell
        }
        return UITableViewCell()
    }
    
    var selectedRoW = Weather()
    
    func animationTransition() {
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoW = getWeatherDB.list[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "infoVC", sender: self)
        animationTransition()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    
    private  func setImageBackground() {
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
            print(" \(UserDefaults.standard.set(lat, forKey: "lat"))\(UserDefaults.standard.set(long, forKey: "long"))")
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
extension WeatherTableViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let findeCity = getDBApi(lat: place.coordinate.latitude, long: place.coordinate.longitude)
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
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
