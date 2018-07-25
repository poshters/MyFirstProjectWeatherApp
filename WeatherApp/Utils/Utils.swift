import Foundation
import UIKit
class Utils {
    
static  func temperatureFormatter(kelvinTemp: Double) -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.init(identifier: "it_IT")
        formatter.numberFormatter.maximumFractionDigits = 0
        let temperature = Measurement(value: kelvinTemp, unit: UnitTemperature.kelvin)
        return (String(format: "%@", formatter.string(from: temperature)))
    }
    
   static func dayOfWeeks(date: Int, separateDataAndDay: Bool = false ) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        let dayOfWeek = DateFormatter()
        dayOfWeek.dateFormat = "EEEE"
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        let newLine = separateDataAndDay ? "\n" : " "
        return  "\(dayOfWeek.string(from: date))\(newLine)\(dateFormatter.string(from: date).capitalized)"
    }
}
