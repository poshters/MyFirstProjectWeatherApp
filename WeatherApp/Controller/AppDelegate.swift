import UIKit
import GooglePlaces
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
   
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let  center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (_, _) in

        }
         GMSPlacesClient.provideAPIKey("AIzaSyAV_OQmWG4kwW0X2HbRtmHOLhP5gcTo8Z4")
        return true
    }
}
