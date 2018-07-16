import Foundation

class DateUtils {

    func getWeather() {
        let responseModel = ApiWeather().getWeatherForecastByCity(city: "Ivano-Frankivsk")
        print("Погода в \(String(describing: responseModel.city?.name))")
        for a in responseModel.list {
            let date = Date(timeIntervalSince1970: TimeInterval(a.dateWeather))
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
            print("\(dateFormatter.string(from:date)) min temp \(a.min) max temp \(a.max)")
        }
    }
}
