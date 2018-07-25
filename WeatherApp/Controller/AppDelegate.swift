import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
   
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         GMSPlacesClient.provideAPIKey("AIzaSyAV_OQmWG4kwW0X2HbRtmHOLhP5gcTo8Z4")
        return true
    }
}
