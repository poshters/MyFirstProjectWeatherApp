//
//  ReachabilityManager.swift
//  WeatherApp
//
//  Created by mac on 7/9/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager {
    static let shared = ReachabilityManager()
    // Boolean to track network reachability
    var isNetworkAvaiLable : Bool {
        return reachability.connection != .none
    }
    // Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachbilityStatus : Reachability.Connection = .none
    // Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    @objc func reachbilityChanged(notification: Notification) {
        let reachbility = notification.object as! Reachability
        switch reachbility.connection {
        case .none:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            print("Network reachable through Cellular Data")
        }
    }
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachbilityChanged(notification:)),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
}
