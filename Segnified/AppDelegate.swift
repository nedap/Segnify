//
//  AppDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 26/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setup the main stack.
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = UINavigationController(rootViewController: MainViewController())
        window!.makeKeyAndVisible()
        return true
    }
}

