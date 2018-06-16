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
    }
    
}

extension UNService: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN Did received response")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN Will Present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
        
    }
}

