//
//  NotificationHelper.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 15/11/21.
//

import Foundation
import UserNotifications

enum NotificationHelper{

    static func enableNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("success!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func setNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "New notification!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Your audio has been added", arguments: nil)
        content.sound = UNNotificationSound.default
         
        // Deliver the notification in five seconds.
        //let trigger = UNTimeIntervalNotificationTrigger(repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        //let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger) // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
             if let theError = error {
                 // Handle any errors
                 
                 print("notification error")
             }
        }
    }
    static var lat : String = "0.0"
    static var long : String = "0.0"
    

}


