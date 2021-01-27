//
//  NotificationHandler.swift
//  Tomodoro
//
//  Created by Thomas Butterwith on 25/01/2021.
//

import Foundation
import UserNotifications


class NotificationHandler {
    init() {
        // do nothing
    }
    
    func sendBreakEndNotification() {
        sendNotification(text: "Break is over")
    }
    
    func sendTimerEndNotification() {
        sendNotification(text: "Time's up!")
    }
    
    func sendNotification(text: String) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        }
        
        let content = UNMutableNotificationContent()
        content.body = text
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
