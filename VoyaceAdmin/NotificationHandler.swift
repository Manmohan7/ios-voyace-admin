//
//  NotificationHandler.swift
//  VoyaceAdmin
//
//  Created by Manmohan Singh on 2023-04-07.
//

import Foundation
import UserNotifications

class NotificationHandler {
    static func createNotification(title: String, description: String) {
        let uuid = UUID().uuidString
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
}
