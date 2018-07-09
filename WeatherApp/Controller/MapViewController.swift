
import UIKit
import MapKit

class MapViewController: UIViewController {
    let weatherTableView = WeatherTableViewController()
    var coord = Coord()

    @IBOutlet weak var mapCoord: MKMapView!
    override func viewDidLoad() {
        let results = DBManager().getWeatherForecastByCity(cityName: "Ivano-Frankivsk")
        if !results.isEmpty {
            coord = results.first!.city!.coord!
        }
        super.viewDidLoad()
        
        let initLocation = CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lon)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: initLocation, span: span)
        mapCoord.setRegion(region, animated: true)
        
    
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
