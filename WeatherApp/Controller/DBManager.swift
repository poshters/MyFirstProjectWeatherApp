import Foundation
import RealmSwift

class DBManager {
    
    @discardableResult
    class func addDB(object: WeatherForecast) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                realm.add(object, update: true)
            }
            return true
        } catch {
            return false
        }
    }
    
    class func  getWeatherForecastByCity(lat: Double, long: Double) -> Results<WeatherForecast>? {
        
        do {
            let realm = try Realm()
            let result = realm.objects(WeatherForecast.self)
            return result
            
        } catch {
            return nil
        }
    }
}
