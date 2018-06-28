//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by mac on 6/27/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    var getWeatherDB = WeatherForecast()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherDB =  getDBApi()
        setImageBackground()
        self.title = getWeatherDB.city?.name
        
    }
    
    // MARK: - Table view data source
 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getWeatherDB.list.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160.0
        } else {
            return 74.0
        }
    }
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell") as? TableViewCell
        let cellGetWeatherDB = getWeatherDB.list[indexPath.row]
        let date = Date(timeIntervalSince1970: TimeInterval(cellGetWeatherDB.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        if indexPath.row == 0 {
            cell?.date.text = "\(dateFormatter.string(from:date))"
            cell?.desc.text = "\(cellGetWeatherDB.desc)"
            cell?.maxTemp.text = "\((Int(cellGetWeatherDB.max)))"
            cell?.minTemp.text = "\(Int(cellGetWeatherDB.min))"
            cell?.imageWeather.image = UIImage(named: "\(cellGetWeatherDB.icon)")
            cell?.backgroundColor = .clear
            return cell!
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SecondTableViewCell
            cell?.secondDate.text = "\(dateFormatter.string(from:date))"
            cell?.secondDesc.text = "\(cellGetWeatherDB.desc)"
            cell?.secondMax.text = "\(Int(cellGetWeatherDB.max))"
            cell?.secondMin.text = "\( Int(cellGetWeatherDB.min))"
            cell?.secondImage.image = UIImage(named: "\(cellGetWeatherDB.icon)")
            cell?.backgroundColor = UIColor(white: 1, alpha: 0.7)
            return cell!
            
        }
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
            (segue.destination as! InfoViewController).selectedRow = selectedRoW
        }
    }
    func getDBApi() -> WeatherForecast {
        let getApiWeather = ApiWeather().getWeatherForecastByCity(city:"Ivano-Frankivsk" )
        DBManager.sharedInstance.addDB(object:getApiWeather)
        getWeatherDB = DBManager.sharedInstance.getWeatherForecastByCity(cityName: (getApiWeather.city?.name)!)
        return getWeatherDB
    }
    func setImageBackground() {
        let backgraundImage = UIImage(named: "1")
        let imageView = UIImageView(image: backgraundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }
    
    
    
}



/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */






