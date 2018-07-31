import Foundation
import CoreLocation

class ApiWeather {
    private let lat = UserDefaults.standard.double(forKey: "lat")
    private let long = UserDefaults.standard.double(forKey: "long")
    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/forecast/daily?"
    private let openWeatherMapAPIKey = "695ec8629eeaf925d9d4e9139ac14a69"
    private let language = Locale.current.languageCode ?? ""

    func getWeatherForecastByCity(lat: Double, long: Double) -> WeatherForecast {
        let semaphore = DispatchSemaphore(value: 0)
        var responseModel = WeatherForecast()
        let session = URLSession.shared

       guard let weatherRequestURL = URL(string:
        "\(openWeatherMapBaseURL)lat=\(lat)&lon=\(long)&cnt=14&lang=\(language)&APPID=\(openWeatherMapAPIKey)") else {
            return WeatherForecast()
        }

        session.dataTask(with: weatherRequestURL) { (data, response, error) in

            guard response != nil else {
                return
            }
            guard let data = data else {
                return

            }
            guard  error == nil else {
                return

            }
            let jsonDecoder = JSONDecoder()
            do {
                responseModel = try jsonDecoder.decode(WeatherForecast.self, from: data)
                semaphore.signal()

            } catch {
                print(error)
            }
            }

            .resume()
        semaphore.wait()
        return responseModel
    }
}
