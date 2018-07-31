import Foundation
import UIKit
import UserNotifications
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
    static func sheduleNotification(title: String, subtitle: String, body: String) {
        let notificationIdentifier = "WeatheNotifacation"
        removeNotifications(withIdentifers: [notificationIdentifier])
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default()
    
        var dateComponents = DateComponents()
        dateComponents.hour = 09
        dateComponents.minute = 21
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
    static internal func removeNotifications(withIdentifers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
