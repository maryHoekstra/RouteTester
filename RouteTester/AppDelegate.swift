//
//  AppDelegate.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // initialize google maps api key
        GMSServices.provideAPIKey("AIzaSyDQgNpFr0lnXhIV1WT4rUikXD17Tf9rdgk")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController: UIViewController
        
        let userConsented = UserDefaults.standard.bool(forKey: "UserConsented")
        // if user has not consented yet
        if !userConsented {
            // show onboarding screen
            print("got here")
            viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
        } else {
        // show main screen
            print("apparently we've consented")
            viewController = storyboard.instantiateInitialViewController()!
        }
        
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.saveContext()
    }

    
}

