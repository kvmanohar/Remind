//
//  UNService.swift
//  Remind
//
//  Created by Manohar Kurapati on 16/06/2018.
//  Copyright © 2018 Manosoft. All rights reserved.
//

import Foundation
import UserNotifications

//Singleton Class
class UNService: NSObject {
    
    private override init(){}
    static let shared = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func autohrise(){
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { (grandted, error) in
            print(error ?? "No Un auth error")
            guard grandted else {
                print ("USER DEINED ACCESS")
                return
            }
            self.configure()
        }
    }//authorise
    
    func configure(){
        unCenter.delegate = self
        setupActionAndCategories()
    }
    
    func setupActionAndCategories(){
        let timerAction = UNNotificationAction(identifier: NotificationActionID.timer.rawValue,
                                               title: "Run timer logic",
                                               options: [.authenticationRequired])
        
        let dateAction = UNNotificationAction(identifier: NotificationActionID.date.rawValue,
                                              title: "Run Date logic",
                                              options: [.destructive])
        let locationAction = UNNotificationAction(identifier: NotificationActionID.location.rawValue,
                                                  title: "Run location logic",
                                                  options: [.foreground])
        
        
        let timerCategory = UNNotificationCategory(identifier: NotificationCategory.timer.rawValue,
                                                  actions: [timerAction], intentIdentifiers: [], options: [])
        
        let dateCategory = UNNotificationCategory(identifier: NotificationCategory.date.rawValue,
                                                  actions: [dateAction], intentIdentifiers: [], options: [])
        let locationCategory = UNNotificationCategory(identifier: NotificationCategory.location.rawValue,
                                                      actions: [locationAction], intentIdentifiers: [], options: [])
        
        unCenter.setNotificationCategories([timerCategory, dateCategory, locationCategory])
        
    }
    
    func getAttachments(for id: NotificationAttachementID) -> UNNotificationAttachment?{
        var imageName: String
        switch  id {
        case .timer: imageName = "TimeAlert"
        case .date:  imageName = "DateAlert"
        case .location: imageName = "LocationAlert"
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil }
        do {
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url)
            return attachment
        } catch {
            return nil
        }
        
    }
    
    func timerRequest(with interval: TimeInterval){
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.timer.rawValue
        
        if let attachment = getAttachments(for: .timer){
            content.attachments = [attachment]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request, withCompletionHandler: nil)
    }
    
    func dateRequest(with components: DateComponents){
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "It is now the future!"
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.date.rawValue
        
        if let attachment = getAttachments(for: .date){
            content.attachments = [attachment]
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: "userNotification.date",
                                            content: content,
                                            trigger: trigger)
        unCenter.add(request, withCompletionHandler: nil)
    }
    
    func locationRequest(){
        let content = UNMutableNotificationContent()
        content.title = "You have returned"
        content.body = "Welcome back you silly coder you!"
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.location.rawValue
        
        if let attachment = getAttachments(for: .location){
            content.attachments = [attachment]
        }
        
        let request = UNNotificationRequest(identifier: "userNotification.location",
                                            content: content,
                                            trigger: nil)
        unCenter.add(request, withCompletionHandler: nil)
    }
    
}//UNService

extension UNService: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN Did received response")
        
        if let action = NotificationActionID(rawValue: response.actionIdentifier){
            NotificationCenter.default.post(name: NSNotification.Name("internalNotification.handleAction"), object: action)
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN Will Present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
        
    }
}

