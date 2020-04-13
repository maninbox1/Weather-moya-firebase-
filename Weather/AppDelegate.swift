//
//  AppDelegate.swift
//  Weather
//
//  Created by Mikhail Ladutska on 3/31/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit
import Moya
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        ViewController.shared.initLocationManager()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        var storyboardID = ""

        if launchedBefore {
            print("Not first launch.")
            storyboardID = "LoadingScreenViewController"
        }  else {
            print("First launch")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            storyboardID = "ViewController"
        }
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationViewController = UINavigationController.init(rootViewController: initialViewController)
        navigationViewController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

