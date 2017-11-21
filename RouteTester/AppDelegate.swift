//
//  AppDelegate.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let locationManager = LocationManager.shared
        locationManager.requestWhenInUseAuthorization()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.saveContext()
    }

    
}

