import UIKit
class WeatherTableViewController: UITableViewController {
    var getWeatherDB = WeatherForecast()
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageBackground()
        self.title = getWeatherDB.city?.name
        self.refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.view.addSubview(refresh)
        checkData()
    }

    @objc func refreshData() {
            checkData()
            tableView.reloadData()
        
        refresh.endRefreshing()
    }
    func checkData() {
        let results = getDBApi()
        if (results?.isEmpty)! {
            alertClose()
        } else {
            getWeatherDB = (results?.first)!
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
            return 200.0
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
            
            cell.dateWeather.text = "\(dayOfWeek.string(from: date))\n\(dateFormatter.string(from: date))"
            cell.desc.text = "\(cellGetWeatherDB.desc)"
            cell.maxTemp.text = "\(Int(cellGetWeatherDB.max))ºC"
            cell.minTemp.text = "\(Int(cellGetWeatherDB.min))ºC"
            cell.imageWeather.image = UIImage(named: "\(cellGetWeatherDB.icon)")
            cell.backgroundColor = .clear
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                           for: indexPath)
            as? SecondTableViewCell {
            cell.secondDate.text = "\(dayOfWeek.string(from: date)), \(dateFormatter.string(from: date))"
            cell.secondDesc.text = "\(cellGetWeatherDB.desc)"
            cell.secondMax.text = "\(Int(cellGetWeatherDB.max))ºC"
            cell.secondMin.text = "\( Int(cellGetWeatherDB.min))ºC"
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
    func getDBApi() -> Results<WeatherForecast>? {
        let city = "Ivano-Frankivsk"
        if Reachability.isConnectedToNetwork() {
            let getApiWeather = ApiWeather().getWeatherForecastByCity(city: city)
            DBManager.addDB(object: getApiWeather)
        }
        let results = DBManager.getWeatherForecastByCity(cityName: city)
        
        return results
        
    }
    @IBAction func findeCityButton(_ sender: Any) {
        
    }
    
    func setImageBackground() {
        let backgraundImage = UIImage(named: "1")
        let imageView = UIImageView(image: backgraundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }
}
