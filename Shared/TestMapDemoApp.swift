//
//  TestMapDemoApp.swift
//  Shared
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI
import Firebase
import GoogleMaps
import GooglePlaces
import UserNotifications


let appDelegate = AppDelegate()

@main
struct TestMapDemoApp: App {

    init() {
       FirebaseApp.configure()
       GMSPlacesClient.provideAPIKey("AIzaSyA3zhMMXy2h2FmStp0QLrJ7BNSNVyBpDv8")
       GMSServices.provideAPIKey("AIzaSyA3zhMMXy2h2FmStp0QLrJ7BNSNVyBpDv8")
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear() {
                UNUserNotificationCenter.current().delegate = appDelegate
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler(.alert)
    }

}
