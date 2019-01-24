//
//  AppDelegate.swift
//  UniversalLinksExample
//
//  Created by Caio Brigagão Lunardi on 18/01/2019.
//  Copyright © 2019 Caio Brigagão Lunardi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let incomingURL = userActivity.webpageURL else {
                return false
        }

        print("path = \(incomingURL.absoluteString)")
        ViewController.configure(link: incomingURL.absoluteString)
        return true
    }
}

